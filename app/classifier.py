import json
import logging
import string
import time
import os

from flask import jsonify
from flask import Blueprint
from flask import current_app as app
from flask import request
import numpy as np
import tensorflow as tf

from app import embedder
from app import model_config as mc
from app import model_fetcher

# The magic ML threshold of values we're confident are relevant enough
RETAIN_THRESHOLD = 0.4
MODEL_CONFIG_PATH = "./static/model_config.json"

classify_bp = Blueprint('classify_bp', __name__)


def loadVocab(vocab: str):
    with open(vocab, 'r') as f:
        return f.readlines()


class Classifier:
    """ Classifier may classify a string sequence's topic probability vector.

        Parameters:
            classifier_model_base_path (str): the local path to the dir
                    containing all saved classifier models and their instances.
            model_name (str): the name of the training model (e.g.
                    UPR_2percent_ps0)
    """

    # TODO: The config should be per model, and should contain the bert and
    # vocab paths, alleviating the need to respecify them here in init.
    def __init__(self,
                 classifier_model_base_path: str,
                 model_name: str,):

        self.logger = logging.getLogger()

        model_config_path = os.path.join(classifier_model_base_path, model_name)
        self._load_instance(model_config_path)

        fq_instance_dir = os.path.join(model_config_path, self.instance)
        self.embedder = embedder.Embedder(self.instance_config.bert)
        self.vocab = loadVocab(
            os.path.join(fq_instance_dir, self.instance_config.vocab))

        self.predictor = tf.contrib.predictor.from_saved_model(fq_instance_dir)

    def _load_instance(
            self, relative_path_to_model: str) -> (str, mc.InstanceConfig):
        instances = os.listdir(relative_path_to_model)
        # pick the latest released instance
        for i in sorted(instances, reverse=True):
            with open(os.path.join(
                    relative_path_to_model, i, "config.json")) as f:
                d = json.loads(f.read())
                if d["is_released"]:
                    self.instance = i
                    self.instance_config = mc.InstanceConfig(d)
                    return
        raise Exception(
            "No valid instance of model found in %s, instances were %s" % (
                relative_path_to_model, instances))

    def classify(self, seq: str) -> [(str, float)]:
        """ classify calculates and returns a particular sequence's topic probability vector.

        Parameters:
            seq (str): The text sequence to be classified with this model.

        Returns:
            [(str, float)]: The topic probabilty vector in descending order,
                    with topics below the minimum threshold (default=0.4)
                    discarded.
        """
        embedding = self.embedder.GetEmbedding(seq)
        input_mask = [1] * embedding.shape[0]

        # classify seq, with its embedding matrix, using a specific model
        features = {
            "embeddings": np.expand_dims(embedding, axis=0),
            "input_mask": np.expand_dims(input_mask, axis=0),
        }

        predictions = self.predictor(features)
        probabilities = predictions["probabilities"][0]
        logging.getLogger().debug(probabilities)

        # map results back to topic strings, according to classifier metadata
        # e.g. [('education', 0.8), ('rights of the child', 0.9)]
        topic_probs = list(zip(
            (topic.rstrip() for topic in self.vocab),
            probabilities))
        # sort the results in descending order of topic probability
        topic_probs.sort(key=lambda tup: tup[1], reverse=True)

        # discard all topic probability tuples who are too unlikely
        topic_probs = [o for o in topic_probs if o[1] > RETAIN_THRESHOLD]
        self.logger.info(
            "Filtered %d results that were at or below the precision "
            "threshold." % (len(self.vocab) - len(topic_probs)))
        return topic_probs


@classify_bp.route('/classify', methods=['POST'])
def classify():
    # request.get_json: {"seq"="hello world", "model"="upr_info_issues"}
    error = None
    data = request.get_json()
    args = request.args

    c = Classifier(
        app.config["BASE_CLASSIFIER_DIR"],
        args["model"])

    results = c.classify(data['seq'])
    return jsonify(str(results))
