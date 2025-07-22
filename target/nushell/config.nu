def rik-install [source: string, ...packages: string] {
  match $source {
    "a" => { paru -S ...$packages },
    "s" => { sudo snap install ...$packages },
    "f" => { flatpak install ...$packages },
    _ => {
      printf ":: Error  : Unknown [source]: '%s'\n" $source
      printf ":: Usage  : rik-install [source] [...packages]\n"
      printf ":: Source : [a]rch, [s]nap, [f]lathub\n" 
      printf ":: Help   : Try passing a, s, or f instead"
      return
    }
  }
}

def rik-query [source: string, package: string] {
  match $source {
    "a" => { paru -Ss $package },
    "s" => { snap search $package },
    "f" => { flatpak search $package },
    _ => {
      printf ":: Error  : Unknown [source]: '%s'\n" $source
      printf ":: Usage  : rik-query [source] [package]\n"
      printf ":: Source : [a]rch, [s]nap, [f]lathub\n" 
      printf ":: Help   : Try passing a, s, or f instead"
      return
    }
  }
}

def rik-remove [source: string, ...packages: string] {
  match $source {
    "a" => { paru -Rns ...$packages },
    "s" => { sudo snap remove ...$packages },
    "f" => { flatpak uninstall ...$packages },
    _ => {
      printf ":: Error  : Unknown [source]: '%s'\n" $source
      printf ":: Usage  : rik-remove [source] [...packages]\n"
      printf ":: Source : [a]rch, [s]nap, [f]lathub\n" 
      printf ":: Help   : Try passing a, s, or f instead"
      return
    }
  }
}

def rik-sync [source?: string] {
  match $source {
    "a" => { paru -Syu --noconfirm },
    "s" => { sudo snap refresh },
    "f" => { flatpak update },
    null => {
      paru -Syu --noconfirm
      sudo snap refresh
      flatpak update
    },
    _ => {
      printf ":: Error  : Unknown [source]: '%s'\n" $source
      printf ":: Usage  : rik-sync [source?]\n"
      printf ":: Source : [a]rch, [s]nap, [f]lathub\n" 
      printf ":: Help   : Try passing a, s, or f instead"
      return
    }
  }
}

def rik-serv [action: string, service: string] {
  def serv [action: string] {
    sudo systemctl $action $service
  }
  match $action {
    "s" => { serv "status" },
    "e" => { serv "enable" },
    "d" => { serv "disable" },
    "t" => { serv "start" },
    "p" => { serv "stop" },
    _ => {
      printf ":: Error  : Unknown [action]: '%s'\n" $action
      printf ":: Usage  : rik-serv [action] [service]\n"
      printf ":: Action : [s]tatus, [e]nable, [d]isable, star[t], sto[p]\n" 
      printf ":: Help   : Try passing s, e, d, t, or p instead"
      return
    }
  }
}

def rik-wifi [action: string, ssid?: string] {
  match $action {
    "c" => {
      if ($ssid == null) {
        printf ":: Error  : Required [ssid] can not be empty while [action]: [c]onnect"
        return
      } else {
        nmcli device wifi connect $ssid
      }
    },
    "l" => { nmcli device wifi list },
    "r" => { nmcli device wifi rescan },
    _ => {
      printf ":: Error  : Unknown [action]: '%s'\n" $action
      printf ":: Usage  : rik-wifi [action] [ssid?]\n"
      printf ":: Action : [c]onnect, [l]ist, [r]escan\n" 
      printf ":: Help   : Try passing c, l, or r instead"
      return
    }
  }
}

def dconfsync [] {
  if (is-admin) {
    print "You are not supposed to run this sync."
    return
  } else {
    cd ($env.HOME)/Projects/dconfsync/
    nu dconfsync
    cd -
  }
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
alias w = rik-wifi
alias x = exit
alias cn = config nu
alias ce = config env

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

source ~/.zoxide.nu
