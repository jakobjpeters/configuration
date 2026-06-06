#!/usr/bin/env sh

git -C /tmp clone https://github.com/jakobjpeters/configuration
sh /tmp/configuration/scripts/install/nu.sh
nu /tmp/configuration/scripts/install/just.nu
just install all
