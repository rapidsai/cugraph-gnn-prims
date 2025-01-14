#!/bin/bash
# Copyright (c) 2024-2025, NVIDIA CORPORATION.

set -euo pipefail

package_dir="python/cugraph-pyg"

source ./ci/use_wheels_from_prs.sh

./ci/build_wheel.sh cugraph-pyg ${package_dir}
./ci/validate_wheel.sh ${package_dir} dist
