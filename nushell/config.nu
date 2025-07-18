def rik-install [source?: string, package?: string, repo?: string] {
  if (($source | is-empty) or ($package | is-empty)) {
    print ":: Error: \e[36m'<package>'\e[0m can't be empty."
    return
  } else {
    match $source {
      "arch" => {
        match $repo {
          "c" => { sudo pacman -S extra/($package) }, 
          "e" => { sudo pacman -S extra/($package) },
          "m" => { sudo pacman -S multilib/($package) },
          "ct" => { sudo pacman -S core-testing/($package) },
          "et" => { sudo pacman -S extra/($package) },
          "mt" => { sudo pacman -S multilib-testing/($package) },
          "ca" => { sudo pacman -S chaotic-aur/($package) },
          _ => { sudo pacman -S $package }
        }
      },
      "aur" => { aura -A $package },
      "snap" => { sudo snap install $package },
      "fpak" => { flatpak install $package },
      _ => {
        printf "Unknown source: '%s'" $source
        return
      }
    }
  }
}

def rik-query [source: string, package: string] {
  match $source {
    "arch" => { aura -Ss $package },
    "aur" => { aura -As $package },
    "snap" => { snap search $package },
    "fpak" => { flatpak search $package },
    _ => {
      printf "Unknown source: '%s'" $source
      return
    }
  }
}

def rik-remove [source: string, package: string] {
  match $source {
    "sys" => { sudo pacman -Rns $package },
    "snap" => { sudo snap remove $package },
    "fpak" => { flatpak uninstall $package },
    _ => {
      printf "Unknown source: '%s'" $source
      return
    }
  }
}

def rik-sync [option?: string] {
  match $option {
    "arch" => { aura -Syu --noconfirm },
    "aur" => { aura -Ayu --noconfirm },
    "snap" => { sudo snap refresh },
    "fpak" => { flatpak update },
    _ => {
      aura -Syu --noconfirm
      aura -Ayu --noconfirm
      sudo snap refresh
      flatpak update
    }
  }
}

def rik-serv [action: string, service: string] {
  def syst [longact: string] {
    sudo systemctl $longact $service
  }
  if ($action == null or $service == null) {
    printf "Argument <action> or <service> can't be empty."
    return
  } else {
    match $action {
      "i" => { syst "status" },
      "e" => { syst "enable" },
      "d" => { syst "disable" },
      "s" => { syst "start" },
      "x" => { syst "stop" },
      _ => {
        printf "Unknown action: '%s'" $action
        return
      }
    }
  }
}

def rik-wifi [action: string, ssid?: string] {
  if ($action | is-empty) {
    print "Argument <action> can't be empty."
    return
  } else {
    match $action {
      "c" => {
        if ($ssid | is-empty) {
          print "Argument <ssid> can't be empty."
          return
        } else {
          nmcli device wifi connect $ssid
        }
      },
      "l" => { nmcli device wifi list },
      _ => {
        printf "Unknown action: '%s'" $action
        return
      }
    }
  }
}

def archsync [] {
  cd ($env.HOME)/Projects/archsync/
  nu archsync.nu
  cd -
}

alias a = rik-serv
alias c = clear
alias d = rm -rf
alias g = grep --color
alias i = rik-install
alias l = ls -la
alias q = rik-query
alias r = rik-remove
alias s = rik-sync
alias v = nvim
alias x = exit
alias cn = config nu
alias ce = config env

source ~/.zoxide.nu
