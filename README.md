# Local-Label-Propagation
Code for the paper 'Local Label Propagation for Effective and Efficient Hyperspectral Images Classification' submitted to IEEE Geoscience and Remote Sensing Letters.

## Parameter:
The datasets name, number of training samples, filter radius, and sigma for spatial kernel.
- datasetName = 'Indianpines'      # Indianpines  PaviaU
- number = 30
- radius = 1
- sigma = 2.0                      # Indianpines:2.0  PaviaU:10.0

## Prerequisites:
Matlab R2021b

## Usage:
- local_label_propagation('Indianpines',30,1,2.0);
