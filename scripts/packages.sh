#!/usr/bin/env bash

set -euo pipefail

export APTARGS="-qq -o=Dpkg::Use-Pty=0"
export DEBIAN_FRONTEND=noninteractive

DEBIAN_FRONTEND=noninteractive apt-get --assume-yes clean ${APTARGS}
DEBIAN_FRONTEND=noninteractive apt-get --assume-yes update ${APTARGS}

DEBIAN_FRONTEND=noninteractive apt-get --assume-yes upgrade ${APTARGS}

DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes ${APTARGS} htop git vim curl wget tar software-properties-common htop unattended-upgrades gpg-agent apt-transport-https ca-certificates thin-provisioning-tools

unattended-upgrades -v

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

DEBIAN_FRONTEND=noninteractive apt-get -y update ${APTARGS}

DEBIAN_FRONTEND=noninteractive apt-get -y install net-tools docker-ce=5:20.10.7~3-0~ubuntu-focal docker-ce-cli=5:20.10.7~3-0~ubuntu-focal containerd.io awscli jq neovim unzip ${APTARGS}

curl -s https://packagecloud.io/install/repositories/netdata/netdata/script.deb.sh | DEBIAN_FRONTEND=noninteractive bash

DEBIAN_FRONTEND=noninteractive apt-get --assume-yes update ${APTARGS}
DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install netdata ${APTARGS}

systemctl enable netdata.service

curl https://releases.hashicorp.com/tfc-agent/1.7.0/tfc-agent_1.7.0_linux_amd64.zip -o tfc-agent_1.7.0_linux_amd64.zip

unzip tfc-agent_1.7.0_linux_amd64.zip

chmod +x tfc-agent

chmod +x tfc-agent-core

cp tfc-agent /usr/local/bin

cp tfc-agent-core /usr/local/bin
