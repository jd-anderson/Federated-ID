# Meta-FedSysID: A federated approach for identifying discrete-time LTI systems

This repository includes the MATLAB codes to implement the experimental results of the following paper:

1) H. Wang, L. F. Toso, J. Anderson (2022). [FedSysID: A Federated Approach to Sample-Efficient System Identification]

## Instructions

To run the codes in this repository, you only need a working MATLAB installation. In this paper we implement our Meta-FedSysId algorithm with two different FL solvers:

* FedAvg - Ref \[1\]
* FedLin - Ref \[2\]

The nominal system considered in our experiments is first presented in Ref \[3\]

**References**

1) Brendan McMahan, Eider Moore, Daniel Ramage, Seth Hampson, Blaise Aguera y Arcas (2017) [Communication-Efficient Learning of Deep Networks from Decentralized Data](https://proceedings.mlr.press/v54/mcmahan17a.html)
2) Aritra Mitra, Rayana Jaafar, George J. Pappas, Hamed Hassani (2021) [Linear Convergence in Federated Learning: Tackling Client Heterogeneity and Sparse Gradients](https://proceedings.neurips.cc/paper/2021/hash/7a6bda9ad6ffdac035c752743b7e9d0e-Abstract.html)
3) Lei Xin, Lintao Ye, George Chiu, Shreyas Sundaram (2022) [Identifying the Dynamics of a System by Leveraging Data from Similar Systems](https://arxiv.org/abs/2204.05446)


## Troubleshooting

If you have any trouble running those codes or have any question about the paper, please email [Leonardo F. Toso](mailto:lt2879@columbia.edu).
