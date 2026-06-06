
#!/usr/bin/env nu

source utilities.nu

log Installing $cargo_packages
cargo install --locked ...$cargo_packages
