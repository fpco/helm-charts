#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

# Install and initialize helm/tiller
HELM_PACKAGES=${1}
HELM_BUCKET_NAME="fpco-charts"
HELM_CHARTS_DIRECTORY=${2:-"$(pwd)/../"}
HELM_CHARTS_PACKAGED_DIR=${3:-"/tmp/helm-packaged"}
HELM_REPO_URL=https://s3.amazonaws.com/${HELM_BUCKET_NAME}/stable/
HELM_INDEX="${HELM_CHARTS_PACKAGED_DIR}/index.yaml"

# Package helm and dependencies
mkdir -p ${HELM_CHARTS_PACKAGED_DIR}
helm init --client-only
helm repo add fpco ${HELM_REPO_URL}

# check if charts has dependencies,
for chart in ${HELM_PACKAGES}
do
    # #  update dependencies before package the chart
    # if ls ${HELM_CHARTS_DIRECTORY}/${chart}
    # do
        cd ${HELM_CHARTS_DIRECTORY}/${chart}
        helm dep update
        helm package . -d ${HELM_CHARTS_PACKAGED_DIR}
        cd -
    # done
done

# donwload the current remote index.yaml
if [ ! -f "${HELM_INDEX}" ]; then
    wget ${HELM_REPO_URL}index.yaml -O "${HELM_INDEX}"
fi

helm repo index ${HELM_CHARTS_PACKAGED_DIR} --url ${HELM_REPO_URL} --debug --merge ${HELM_INDEX}
