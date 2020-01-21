import math
from typing import Any, List, Tuple

import numpy as np
import pandas as pd

from app.TopicInfo import TopicInfo


def compute_precision(true_pos: float, false_pos: float) -> float:
    if true_pos + false_pos > 0:
        return true_pos / (true_pos + false_pos)
    return 0.0


def compute_recall(true_pos: float, train_probs: List[float]) -> float:
    if len(train_probs) > 0:
        return true_pos / len(train_probs)
    return 0.0


def compute_f1(precision: float, recall: float) -> float:
    if precision + recall > 0:
        return 2 * (precision * recall / (precision + recall))
    return 0.0


def compute_scores(train_probs: List[float], false_probs: List[float],
                   thres: float) -> Tuple[float, float, float]:
    true_pos = sum([1.0 for p in train_probs if p >= thres])
    false_pos = sum([1.0 for p in false_probs if p >= thres])

    precision = compute_precision(true_pos, false_pos)
    recall = compute_recall(true_pos, train_probs)
    f1 = compute_f1(precision, recall)

    return (f1, precision, recall)


def build_score_matrix(train_probs: List[float],
                       false_probs: List[float]) -> pd.DataFrame:
    scores = []
    for thres in np.arange(0.05, 1, 0.05):
        f1, precision, recall = compute_scores(train_probs, false_probs, thres)
        scores.append((thres, f1, precision, recall))

    matrix = pd.DataFrame(scores, columns=['threshold', 'f1',
                                           'precision', 'recall'])
    return matrix.round(2)


def optimize_threshold(scores: pd.DataFrame, min_prec: float = 0.3) -> Any:
    scores = scores[scores.precision >= min_prec]
    # if minimum precision is not achived return default threshold
    if len(scores) == 0:
        return 0.5
    max_f1 = scores.f1.max()
    thresholds = scores[scores.f1 == max_f1].threshold
    # if at multiple thresholds the max f1 is reached select central index
    if len(thresholds) > 1:
        central_ind = math.floor(len(thresholds) / 2)
        return thresholds.iloc[central_ind]
    return thresholds.iloc[0]


def ComputeThresholds(topic: str, train_probs: List[float],
                      false_probs: List[float]) -> TopicInfo:

    ti = TopicInfo(topic)
    ti.num_samples = len(train_probs)

    # use default threshold if too less samples are provided
    if ti.num_samples < 10:
        f1, precision, recall = compute_scores(train_probs, false_probs,
                                               ti.suggested_threshold)
        ti.f1_quality_at_suggested = f1
        ti.precision_at_suggested = precision
        return ti

    # else optimize threshold based on scores
    scores = build_score_matrix(train_probs, false_probs)
    threshold = optimize_threshold(scores)
    ti.scores = scores
    ti.suggested_threshold = threshold
    ti.precision_at_suggested = scores[scores.threshold ==
                                       threshold].precision.iloc[0]
    ti.f1_quality_at_suggested = scores[scores.threshold ==
                                        threshold].f1.iloc()[0]

    return ti
