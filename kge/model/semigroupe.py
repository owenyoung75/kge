import torch
from torch import Tensor
import math

from kge import Config, Dataset
from kge.model.kge_model import RelationalScorer, KgeModel
from torch.nn import functional as F


class SemiGroupEScorer(RelationalScorer):
    r"""Implementation of the SemiGroupE KGE scorer.
    """

    def __init__(self, config: Config, dataset: Dataset, configuration_key=None):
        super().__init__(config, dataset, configuration_key)
        self._norm = self.get_option("l_norm")
        self._subdim = self.get_option("sub_dim")
        self._copies = self.get_option("number_of_copies")

    def score_emb(self, s_emb, p_emb, o_emb, combine: str):
        if combine not in ["sp_", "spo"]:
            raise Exception(
                "Combine {} not supported in SemiGroupE's score function".format(combine)
            )
        n = p_emb.size(0)
        o_calc = torch.matmul(
            s_emb.view(n, self._copies, self._subdim),
            p_emb.view(n, self._subdim, self._subdim)
        ).view(n, -1)
        if combine == "spo":
            return - F.pairwise_distance(o_calc, o_emb, p=self._norm, keepdim=True)
        else:
            return - torch.cdist(o_calc, o_emb, p=self._norm)


class SemiGroupE(KgeModel):
    r"""Implementation of the SemiGroupE KGE model."""

    def __init__(
        self,
        config: Config,
        dataset: Dataset,
        configuration_key=None,
        init_for_load_only=False,
    ):
        self._init_configuration(config, configuration_key)
        self.set_option(
            "entity_embedder.dim", 
            self.get_option("number_of_copies") * self.get_option("sub_dim")
        )
        self.set_option(
            "relation_embedder.dim", 
            self.get_option("sub_dim") * self.get_option("sub_dim")
        )
        super().__init__(
            config=config,
            dataset=dataset,
            scorer=SemiGroupEScorer(config, dataset, self.configuration_key),
            configuration_key=self.configuration_key,
            init_for_load_only=init_for_load_only,
        )

    def score_spo(self, s: Tensor, p: Tensor, o: Tensor, direction=None) -> Tensor:
        # We overwrite this method to ensure that ConvE only predicts towards objects.
        # If ConvE is wrapped in a reciprocal relations model, this will always be the
        # case.
        if direction == "o":
            return super().score_spo(s, p, o, direction)
        else:
            raise ValueError("SemiGroupE can only score objects")
