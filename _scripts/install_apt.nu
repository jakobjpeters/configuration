
#!/usr/bin/env nu

source utilities.nu

log Installing $apt_packages
apt install --yes ...$apt_packages
