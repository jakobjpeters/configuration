
#!/usr/bin/env bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install nu --locked
nu scripts/install.nu
