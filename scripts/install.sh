#!/usr/bin/env sh

echo Installing configuration

echo Updating \`apt\`
apt update

echo Installing \`build-essential\`, \`curl\`
apt install --yes build-essential curl

echo Installing \`rustup\`
# https://rustup.rs/
curl --fail --proto '=https' --silent --show-error --tlsv1.2 https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"

echo Installing \`nu\`
cargo install --locked nu
