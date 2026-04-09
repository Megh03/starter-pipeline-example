#!/bin/bash

function generate_number() {
  MAX_NUMBER=${MAX_NUMBER:-9}
  echo $(( $RANDOM % $MAX_NUMBER + 1))
}

parallel_index=${1:-}

generated_number=$(generate_number)

if [[ -n "$parallel_index" ]]; then
  ( set -x ; buildkite-agent meta-data set "generated-number::$parallel_index" "${generated_number}" )
else
  ( set -x ; buildkite-agent meta-data set "generated-number" "${generated_number}" )
fi

echo
echo#!/bin/bash

(
  set -x

  env | sort

  uname -a
)

if [[ -x "$(command -v node)" ]]; then
  ( set -x; node --version )
else
  echo "WARN: NodeJS not installed"
fi

if [[ -x "$(command -v yarn)" ]]; then
  ( set -x; yarn --version )
else
  echo "WARN: Yarn not installed"
fi
