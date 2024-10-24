#!/usr/bin/env bash
set -ex

[[ $(uname) = Linux ]] || exit 1
[[ $USER = root ]] || exit 1

if grep -q dolly /etc/passwd ; then
  echo "User dolly already exists"
else
  adduser dolly --gecos "" --disabled-password --quiet
  adduser dolly sudo
  adduser dolly adm
  echo "dolly ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
  id dolly

  [[ -r /dolly-scratch/id_ecdsa ]] || exit 1
  [[ -r /dolly-scratch/id_ecdsa.pub ]] || exit 1

  sudo -u dolly bash -c "
    echo 'PATH=\"/home/dolly/.cargo/bin:$PATH\"' > /home/dolly/.profile
    mkdir -p /home/dolly/.ssh/
    cd /home/dolly/.ssh/
    cp /dolly-scratch/id_ecdsa.pub authorized_keys
    umask 377
    cp /dolly-scratch/id_ecdsa id_ecdsa
    echo \"
      Host *
      BatchMode yes
      IdentityFile ~/.ssh/id_ecdsa
      StrictHostKeyChecking no
    \" > config
  "
fi
