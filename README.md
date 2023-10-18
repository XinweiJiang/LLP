# Local-Label-Propagation
- The use of local label propagation can drastically reduce the construction space cost of the global graph, while the use of patches for label passing can quickly obtain classification results without the need for a training process.

## Parameter:
The datasets name, number of training samples, filter radius, and sigma for spatial kernel.
- datasetName = 'Indianpines'      # Indianpines  PaviaU
- number = 30
- radius = 1
- sigma = 2.0                      # Indianpines:2.0  PaviaU:10.0

## Prerequisites:
Use Matlab R2021b

## Usage:
- local_label_propagation('Indianpines',30,1,2.0);
