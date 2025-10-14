#!/usr/bin/env nu

(alacritty
  --option "window.opacity = 1" 'window.startup_mode = "Fullscreen"'
  --command nu --commands "cmatrix -absu 10 | lolcat --freq 0.0005 --seed (random int)")
xdg-screensaver lock
