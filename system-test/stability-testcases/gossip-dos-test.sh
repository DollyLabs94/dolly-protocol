#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"
SOLANA_ROOT="$(cd ../..; pwd)"

logDir="$PWD"/logs
rm -rf "$logDir"
mkdir "$logDir"

dollyInstallDataDir=$PWD/releases
dollyInstallGlobalOpts=(
  --data-dir "$dollyInstallDataDir"
  --config "$dollyInstallDataDir"/config.yml
  --no-modify-path
)

# Install all the dolly versions
bootstrapInstall() {
  declare v=$1
  if [[ ! -h $dollyInstallDataDir/active_release ]]; then
    sh "$SOLANA_ROOT"/install/dolly-install-init.sh "$v" "${dollyInstallGlobalOpts[@]}"
  fi
  export PATH="$dollyInstallDataDir/active_release/bin/:$PATH"
}

bootstrapInstall "edge"
dolly-install-init --version
dolly-install-init edge
dolly-gossip --version
dolly-dos --version

killall dolly-gossip || true
dolly-gossip spy --gossip-port 8001 > "$logDir"/gossip.log 2>&1 &
dollyGossipPid=$!
echo "dolly-gossip pid: $dollyGossipPid"
sleep 5
dolly-dos --mode gossip --data-type random --data-size 1232 &
dosPid=$!
echo "dolly-dos pid: $dosPid"

pass=true

SECONDS=
while ((SECONDS < 600)); do
  if ! kill -0 $dollyGossipPid; then
    echo "dolly-gossip is no longer running after $SECONDS seconds"
    pass=false
    break
  fi
  if ! kill -0 $dosPid; then
    echo "dolly-dos is no longer running after $SECONDS seconds"
    pass=false
    break
  fi
  sleep 1
done

kill $dollyGossipPid || true
kill $dosPid || true
wait || true

$pass && echo Pass
