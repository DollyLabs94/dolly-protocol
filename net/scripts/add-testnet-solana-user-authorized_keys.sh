#!/usr/bin/env bash
set -ex

[[ $(uname) = Linux ]] || exit 1
[[ $USER = root ]] || exit 1

[[ -d /home/dolly/.ssh ]] || exit 1

if [[ ${#SOLANA_PUBKEYS[@]} -eq 0 ]]; then
  echo "Warning: source dolly-user-authorized_keys.sh first"
fi

# dolly-user-authorized_keys.sh defines the public keys for users that should
# automatically be granted access to ALL testnets
for key in "${SOLANA_PUBKEYS[@]}"; do
  echo "$key" >> /dolly-scratch/authorized_keys
done

sudo -u dolly bash -c "
  cat /dolly-scratch/authorized_keys >> /home/dolly/.ssh/authorized_keys
"
