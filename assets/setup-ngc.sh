#!/usr/bin/env bash
# setup-ngc.sh
#
# This script downloads and installs the NVIDIA NGC CLI tool.
set -euo pipefail
NGC_VERSION="${NGC_VERSION:-3.49.0}"
NGC_EXPECTED_SHA256="${NGC_EXPECTED_SHA256:-a7569bc82d8c8e146a17f010a07ea10dcfa28bdd6bc68850204f17f93730247e}"

wget -qO ngccli_linux.zip "https://api.ngc.nvidia.com/v2/resources/nvidia/ngc-apps/ngc_cli/versions/${NGC_VERSION}/files/ngccli_linux.zip"
if [[ $(sha256sum ngccli_linux.zip | cut -d' ' -f1) != "${NGC_EXPECTED_SHA256}" ]]; then
    echo "SHA256 check failed"
    exit 1
fi
if ! command -v unzip > /dev/null; then
   echo "missing the unzip command"
   apt-get install -y unzip
fi
unzip -qo ngccli_linux.zip
for profile in ~/.bash_profile ~/.bashrc ~/.zshrc; do
    if [[ -f "$profile" ]]; then
        if ! grep -q "PATH.*ngc-cli" "$profile" 2>/dev/null; then
            echo "export PATH=\"\$PATH:$(pwd)/ngc-cli\"" >> "$profile"
        fi
    fi
done
echo "NGC CLI v${NGC_VERSION} installed. Restart terminal or source profile to use."
echo "Alternatively, you can use an explicit path to: $(pwd)/ngc-cli/ngc"
