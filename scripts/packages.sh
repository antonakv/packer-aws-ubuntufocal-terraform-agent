#!/usr/bin/env bash

set -euo pipefail

export APTARGS="-qq -o=Dpkg::Use-Pty=0"
export DEBIAN_FRONTEND=noninteractive

sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes clean ${APTARGS}
sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes update ${APTARGS}

sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes upgrade ${APTARGS}

sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes ${APTARGS} htop git vim curl wget tar software-properties-common htop unattended-upgrades gpg-agent apt-transport-https ca-certificates thin-provisioning-tools

sudo unattended-upgrades -v

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo DEBIAN_FRONTEND=noninteractive apt-get -y update ${APTARGS}

sudo DEBIAN_FRONTEND=noninteractive apt-get -y install net-tools docker-ce=5:20.10.7~3-0~ubuntu-focal docker-ce-cli=5:20.10.7~3-0~ubuntu-focal containerd.io awscli jq neovim unzip ${APTARGS}

curl -s https://packagecloud.io/install/repositories/netdata/netdata/script.deb.sh | sudo DEBIAN_FRONTEND=noninteractive bash

sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes update ${APTARGS}
sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install netdata ${APTARGS}

sudo systemctl enable netdata.service

sudo curl https://releases.hashicorp.com/tfc-agent/1.3.0/tfc-agent_1.3.0_linux_amd64.zip -o tfc-agent_1.3.0_linux_amd64.zip

sudo unzip tfc-agent_1.3.0_linux_amd64.zip

sudo chmod +x tfc-agent

sudo chmod +x tfc-agent-core

sudo cp tfc-agent /usr/local/bin

sudo cp tfc-agent-core /usr/local/bin
