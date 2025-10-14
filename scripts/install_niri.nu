#!/usr/bin/env nu

let clones: string = $"($nu.home-path)/code/clones"
apt install --yes git
mkdir $clones
cd $clones

apt install --yes gcc clang libudev-dev libgbm-dev libxkbcommon-dev libegl1-mesa-dev libwayland-dev libinput-dev libdbus-1-dev libsystemd-dev libseat-dev libpipewire-0.3-dev libpango1.0-dev libdisplay-info-dev
git clone https://github.com/YaLTeR/niri
cd niri
git checkout v25.08
cargo build --release

for paths in [
    { source: target/release/niri, target: /usr/local/bin/ }
    { source: resources/niri-session, target: /usr/local/bin/ }
    { source: resources/niri.desktop, target: /usr/local/share/wayland-sessions/ }
    { source: resources/niri-portals.conf, target: /usr/local/share/xdg-desktop-portal/ }
    { source: resources/niri.service, target: /etc/systemd/user/ }
    { source: resources/niri-shutdown.target, target: /etc/systemd/user/ }
    { source: resources/dinit/niri, target: /etc/dinit.d/user/ }
    { source: resources/dinit/niri-shutdown, target: /etc/dinit.d/user/ }
] {
    mkdir $paths.target
    ln --force --symbolic $"($clones)/niri/($paths.source)" $paths.target
}
