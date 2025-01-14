# Copyright (c) 2025, NVIDIA CORPORATION.

RAPIDS_PY_CUDA_SUFFIX="$(rapids-wheel-ctk-name-gen ${RAPIDS_CUDA_VERSION})"

RAFT_COMMIT="d275c995fb51310d1340fe2fd6d63d0bfd43cafa"
LIBRAFT_CHANNEL=$(
  RAPIDS_PY_WHEEL_NAME="libraft_${RAPIDS_PY_CUDA_SUFFIX}" rapids-get-pr-wheel-artifact raft 2531 cpp "${RAFT_COMMIT:0:7}"
)
PYLIBRAFT_CHANNEL=$(
  RAPIDS_PY_WHEEL_NAME="pylibraft_${RAPIDS_PY_CUDA_SUFFIX}" rapids-get-pr-wheel-artifact raft 2531 python "${RAFT_COMMIT:0:7}"
)
RAFT_DASK_CHANNEL=$(
  RAPIDS_PY_WHEEL_NAME="raft_dask_${RAPIDS_PY_CUDA_SUFFIX}" rapids-get-pr-wheel-artifact raft 2531 python "${RAFT_COMMIT:0:7}"
)

CUGRAPH_COMMIT="8fe1d33cbcaf1f40a6b3d06ec48cc699c47f8b44"
CUGRAPH_CHANNEL=$(
  RAPIDS_PY_WHEEL_NAME="cugraph_${RAPIDS_PY_CUDA_SUFFIX}" rapids-get-pr-wheel-artifact cugraph 4804 python "${CUGRAPH_COMMIT:0:}"
)
LIBCUGRAPH_CHANNEL=$(
  RAPIDS_PY_WHEEL_NAME="libcugraph_${RAPIDS_PY_CUDA_SUFFIX}" rapids-get-pr-wheel-artifact cugraph 4804 cpp "${CUGRAPH_COMMIT:0:7}"
)
PYLIBCUGRAPH_CHANNEL=$(
  RAPIDS_PY_WHEEL_NAME="pylibcugraph_${RAPIDS_PY_CUDA_SUFFIX}" rapids-get-pr-wheel-artifact cugraph 4804 python "${CUGRAPH_COMMIT:0:}"
)

cat > ./constraints.txt <<EOF
cugraph-${RAPIDS_PY_CUDA_SUFFIX} @ file://$(echo ${CUGRAPH_CHANNEL}/cugraph_*.whl)
libcugraph-${RAPIDS_PY_CUDA_SUFFIX} @ file://$(echo ${LIBCUGRAPH_CHANNEL}/libcugraph_*.whl)
libraft-${RAPIDS_PY_CUDA_SUFFIX} @ file://$(echo ${LIBRAFT_CHANNEL}/libraft_*.whl)
pylibcugraph-${RAPIDS_PY_CUDA_SUFFIX} @ file://$(echo ${PYLIBCUGRAPH_CHANNEL}/pylibcugraph_*.whl)
pylibraft-${RAPIDS_PY_CUDA_SUFFIX} @ file://$(echo ${PYLIBRAFT_CHANNEL}/pylibraft_*.whl)
raft-dask-${RAPIDS_PY_CUDA_SUFFIX} @ file://$(echo ${RAFT_DASK_CHANNEL}/raft_dask_*.whl)
EOF

export PIP_CONSTRAINT=$(pwd)/constraints.txt
