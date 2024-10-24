#!/usr/bin/env bash

set -x
! tmux list-sessions || tmux kill-session
declare sudo=
if sudo true; then
  sudo="sudo -n"
fi

echo "pwd: $(pwd)"
for pid in dolly/*.pid; do
  pgid=$(ps opgid= "$(cat "$pid")" | tr -d '[:space:]')
  if [[ -n $pgid ]]; then
    $sudo kill -- -"$pgid"
  fi
done
if [[ -f dolly/netem.cfg ]]; then
  dolly/scripts/netem.sh delete < dolly/netem.cfg
  rm -f dolly/netem.cfg
fi
dolly/scripts/net-shaper.sh cleanup
for pattern in validator.sh boostrap-leader.sh dolly- remote- iftop validator client node; do
  echo "killing $pattern"
  pkill -f $pattern
done
