
print "Updating configuration"

source utilities.nu

print "Updating `apt` packages"
apt update
apt upgrade

log "Updating" $cargo_packages
cargo install --locked ...$cargo_packages

# TODO: update Helix, Julia

print "Finished updating configuration"
