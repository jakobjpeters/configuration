
print "Updating configuration"

source utilities.nu

print "Updating `apt` packages"
sudo apt update
sudo apt upgrade

log Updating [Julia Rust]
juliaup update
rustup update

log Updating ...$cargo_packages
cargo install --locked ...$cargo_packages

# TODO: update Helix

print "Finished updating configuration"
