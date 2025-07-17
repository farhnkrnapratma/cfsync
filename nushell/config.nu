$env.config.show_banner = false
$env.EDITOR = "nvim"

def install_package [source: string, package: string, repo?: string] {
  match $source {
    "arch" => {
      match $repo {
        "c" => { aura -S extra/($package) },
        "ct" => { aura -S core-testing/($package) },
        "e" => { aura -S extra/($package) },
        "et" => { aura -S extra/($package) },
        "m" => { aura -S multilib/($package) },
        "mt" => { aura -S multilib-testing/($package) },
        "caur" => { aura -S chaotic-aur/($package) },
        _ => { aura -S $package }
      }
    },
    "aur" => { aura -A aur/($package) },
    "snap" => { sudo snap install $package },
    "fhub" => { flatpak install $package },
    _ => { echo "Unknown source" }
  }
}

def search_package [source: string, package: string] {
  match $source {
    "arch" => { aura -Ss $package },
    "aur" => { aura -As $package },
    "snap" => { snap search $package },
    "fhub" => { flatpak search $package },
    _ => { echo "Unknown source" }
  }
}

def uninstall_package [source: string, package: string] {
  match $source {
    "sys" => { sudo pacman -Rns $package },
    "snap" => { sudo snap remove $package },
    "fhub" => { flatpak uninstall $package },
    _ => { echo "Unknown" }
  }
}

def update_package [option?: string] {
  match $option {
    "arch" => { aura -Syu },
    "aur" => { aura -Ayu },
    "snap" => { sudo snap refresh },
    "fhub" => { flatpak refresh },
    _ => {
      aura -Syu
      aura -Ayu
      sudo snap refresh
      flatpak update
    }
  }
}

def nmc [ssid: string] {
  if ($ssid | is-empty) == 0 {
    echo "SSID can't be empty."
    return
  } else {
    nmcli device wifi connect $ssid --ask
  }
}

def nml [] {
  nmcli device wifi list
}

alias c = clear
alias d = rm -rf
alias g = grep --color
alias i = install_package
alias l = ls -la
alias r = uninstall_package
alias s = search_package
alias u = update_package
alias x = exit
alias nuc = ^$env.EDITOR $nu.config-path

source ~/.zoxide.nu
