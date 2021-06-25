#!/bin/bash

# build in 2 steps
function build_images() {
  docker-compose build --parallel -- builder l2geth l1_chain
  docker-compose build --parallel -- deployer dtl batch_submitter relayer
}

current_dir=$(dirname "$0")

git clone https://github.com/ethereum-optimism/optimism.git
cd optimism/ops
git checkout master

# Use 1B gas for the block gas limit
sed -i  's/TARGET_GAS_LIMIT=11000000/TARGET_GAS_LIMIT=1000000000/g' envs/geth.env

# enabling the Docker BuildKit is recommended
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

build_images
docker-compose up -d
../../${current_dir}/wait-for-sequencer.sh
