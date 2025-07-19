# TODO: Enhance all functionalities
# TODO: Design workflow of osync

def rik-install [source: string, ...packages: string] {
  for $package in $packages {
    match $source {
      "a" => { paru -S $package },
      "s" => { sudo snap install $package },
      "f" => { flatpak install $package },
      _ => {
        printf ":: Error  : Unknown [source]: '%s'\n" $source
        printf ":: Usage  : rik-install [source] [package] [repo?]\n"
        printf ":: Source : [a]rch/aur, [s]nap, [f]lathub\n" 
        printf ":: Help   : Try passing a, s, or f instead"
        return
      }
    }
  }
}

def rik-query [source: string, package: string] {
  match $source {
    "a" => { paru -Ss $package },
    "s" => { snap search $package },
    "f" => { flatpak search $package },
    _ => {
      printf "Unknown source: '%s'" $source
      return
    }
  }
}

def rik-rm [source: string, package: string] {
  match $source {
    "a" => { paru -Rns $package },
    "s" => { sudo snap remove $package },
    "f" => { flatpak uninstall $package },
    _ => {
      printf "Unknown source: '%s'" $source
      return
    }
  }
}

def rik-sync [option?: string] {
  match $option {
    "a" => { paru -Syu --noconfirm },
    "s" => { sudo snap refresh },
    "f" => { flatpak update },
    _ => {
      paru -Syu --noconfirm
      sudo snap refresh
      flatpak update
    }
  }
}

def rik-serv [action: string, service: string] {
  def serv [action: string] {
    sudo systemctl $action $service
  }
  match $action {
    "i" => { serv "status" },
    "e" => { serv "enable" },
    "d" => { serv "disable" },
    "s" => { serv "start" },
    "x" => { serv "stop" },
    _ => {
      printf "Unknown action: '%s'" $action
      return
    }
  }
}

def rik-wifi [action: string, ssid?: string] {
  match $action {
    "c" => {
      if ($ssid == null) {
        print ":: Error: Argument <ssid> can not be empty"
        return
      } else {
        nmcli device wifi connect $ssid
      }
    },
    "l" => { nmcli device wifi list },
    "r" => { nmcli device wifi rescan },
    _ => {
      printf ":: Error: Undefined <action>: '%s'" $action
      return
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
alias r = rik-rm
alias s = rik-sync
alias v = nvim
alias w = rik-wifi
alias x = exit
alias cn = config nu
alias ce = config env

source ~/.zoxide.nu

