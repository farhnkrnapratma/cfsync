#!/bin/nu

let repos = [cosmic-desktop helix libreoffice limine obs qbittorrent qutebrowser thunderbird warp zen-browser]

for $repo in $repos {
  git clone --depth=1 $"https://github.com/catppuccin/($repo).git"
}
