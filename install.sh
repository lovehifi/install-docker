#! /bin/bash

DOCKER_GPG_FILE="/usr/share/keyrings/docker-archive-keyring.gpg"
INSTALLING=1

[ -z "${OPT_DIR}" ]
check_root
echo "Installing Docker..."
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
if [ -f "${DOCKER_GPG_FILE}" ]; then
  rm "${DOCKER_GPG_FILE}"
fi
sudo curl -fsSL https://download.docker.com/linux/debian/gpg |  gpg --dearmor -o "${DOCKER_GPG_FILE}"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=${DOCKER_GPG_FILE}] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" |  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose
echo "Docker installed."

#wget -O - https://raw.githubusercontent.com/lovehifi/install-docker/main/install.sh | sh
