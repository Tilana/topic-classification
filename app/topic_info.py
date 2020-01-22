import json
from typing import Any, Dict

import pandas as pd


class TopicInfo:
    """Collect thresholding and quality information about one topic."""

    def __init__(self, topic: str):
        self.topic = topic
        self.num_samples = 0
        self.suggested_threshold = 0.5
        self.scores = pd.DataFrame(
            columns=['threshold', 'f1', 'precision', 'recall'])

    def to_json_dict(self) -> Dict[str, Any]:
        obj_dict = self.__dict__
        obj_dict['scores'] = json.loads(self.scores.to_json(orient='index'))
        return obj_dict

    def load_json_dict(self, v: Dict[str, Any]) -> None:
        self.__dict__ = v
        self.scores = pd.DataFrame.from_dict(self.scores, orient='index')
        self.scores.index = self.scores.index.map(float)

    def get_quality(self) -> Any:
        return self.scores.loc[self.suggested_threshold].f1

    def get_confidence_at_probability(self, prob: float) -> Any:
        # TODO: include distance between threshold and probability
        scores = self.scores[self.scores.index >= prob]
        if len(scores) > 0:
            quality = scores.iloc[0].f1
            return quality
        return 0.5

    def __str__(self) -> str:
        res = [
            '%s has %d train, suggested quality %.02f@t=%.02f' %
            (self.topic, self.num_samples, self.get_quality(),
             self.suggested_threshold)
        ]
        return '\n'.join(res)
