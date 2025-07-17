$env.config.show_banner = false
$env.EDITOR = "nvim"

# TODO: Fix install_package issues where it can't behave correctly as expected

def install_package [source: string, repo?: string, ...packages: string] {
  let my_packages = if ($packages | describe) == "string" {
    [$packages]
  } else {
    $packages
  }
  for $package in $my_packages {
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
      "snap" => { sudo snap install ...$package },
      "fhub" => { flatpak install ...$package },
      _ => { echo "Unknown source" }
    }
  }
}

def search_package [package: string, source: string] {
  match $source {
    "arch" => { aura -Ss $package },
    "aur" => { aura -As $package },
    "snap" => { snap search $package },
    "fhub" => { flatpak search $package },
    _ => { echo "Unknown source" }
  }
}

def update_system [option?: string] {
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

def nm [action: string, ssid?: string] {
  match $action {
    "c" => { nmcli device wifi connect $ssid --ask },
    "l" => { nmcli device wifi list }
    _ => { nmcli device wifi connect $ssid --ask }
  }
}

alias c = clear
alias d = rm -rf
alias x = exit
alias i = install_package
alias l = ls -la
alias s = search_package
alias u = update_system
alias grep = grep --color

source ~/.zoxide.nu
