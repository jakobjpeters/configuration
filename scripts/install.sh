
echo Updating \`apt\`
apt update

echo Installing \`build-essential\`, \`curl\`
apt install --yes build-essential curl

echo Installing \`rustup\`
curl --fail --proto '=https' --silent --show-error --tlsv1.2 https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"

echo Installing \`nu\`
cargo install --locked nu

nu scripts/install.nu
