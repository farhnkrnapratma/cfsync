#!/bin/sh

cfg="$HOME/.config"

rsync -av --delete $cfg/aura/ ./aura/
rsync -av --delete $cfg/wezterm/ ./wezterm/
rsync -av --delete $cfg/nvim/ ./nvim/
rsync -av --delete $cfg/nushell/ ./nushell/
rsync -av --delete $cfg/cosmic/ ./cosmic/
rsync -av --delete $cfg/BetterDiscord/ ./BetterDiscord/
rsync -av --delete $cfg/starship.toml ./starship.toml
