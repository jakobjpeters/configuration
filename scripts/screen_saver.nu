#!/usr/bin/env nu

(alacritty
  --option "window.opacity = 1"
  --command nu --commands "cmatrix -absu 10 | lolcat --freq 0.0005")
