
#!/usr/bin/env sh

set -euo pipefail

echo Installing \`build-essential\` and \`curl\`
sudo apt install --yes build-essential curl

echo Installing \`cargo\`
curl https://sh.rustup.rs -sSf | sh -s -- -y

echo Installing \`nu\`
cargo install --locked nu
