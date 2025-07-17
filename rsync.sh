#!/bin/sh

cfg="$HOME/.config"

rsync -av $cfg/aura/ ./aura/
rsync -av $cfg/wezterm/ ./wezterm/
rsync -av $cfg/nvim/ ./nvim/
rsync -av $cfg/nushell/ ./nushell/
rsync -av $cfg/cosmic/ ./cosmic/
rsync -av $cfg/BetterDiscord/ ./BetterDiscord/
rsync -av $cfg/starship.toml ./starship.toml
