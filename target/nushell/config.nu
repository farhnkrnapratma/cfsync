def erika-install [source: string, ...packages: string] {
  match $source {
    "a" => { yay -S --disable-download-timeout ...$packages },
    "s" => { sudo snap install ...$packages },
    "f" => { flatpak install ...$packages },
    _ => {
      printf ":: Error  : Unknown [source]: '%s'\n" $source
      printf ":: Usage  : erika-install [source] [...packages]\n"
      printf ":: Source : [a]rch, [s]nap, [f]lathub\n"
      printf ":: Help   : Try passing a, s, or f instead"
      return
    }
  }
}

def erika-query [source: string, package: string] {
  match $source {
    "a" => { yay -Ss $package },
    "s" => { snap search $package },
    "f" => { flatpak search $package },
    _ => {
      printf ":: Error  : Unknown [source]: '%s'\n" $source
      printf ":: Usage  : erika-query [source] [package]\n"
      printf ":: Source : [a]rch, [s]nap, [f]lathub\n"
      printf ":: Help   : Try passing a, s, or f instead"
      return
    }
  }
}

def erika-remove [source: string, ...packages: string] {
  match $source {
    "a" => { yay -Rnsdd ...$packages },
    "s" => { sudo snap remove ...$packages },
    "f" => { flatpak uninstall ...$packages },
    _ => {
      printf ":: Error  : Unknown [source]: '%s'\n" $source
      printf ":: Usage  : erika-remove [source] [...packages]\n"
      printf ":: Source : [a]rch, [s]nap, [f]lathub\n"
      printf ":: Help   : Try passing a, s, or f instead"
      return
    }
  }
}

def erika-sync [source?: string] {
  match $source {
    "a" => { yay -Syu --disable-download-timeout --noconfirm },
    "s" => { sudo snap refresh },
    "f" => { flatpak update },
    null => {
      yay -Syu --noconfirm
      sudo snap refresh
      flatpak update
    },
    _ => {
      printf ":: Error  : Unknown [source]: '%s'\n" $source
      printf ":: Usage  : erika-sync [source?]\n"
      printf ":: Source : [a]rch, [s]nap, [f]lathub\n"
      printf ":: Help   : Try passing a, s, or f instead"
      return
    }
  }
}

def erika-serv [action: string, service: string] {
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
      printf ":: Usage  : erika-serv [action] [service]\n"
      printf ":: Action : [s]tatus, [e]nable, [d]isable, star[t], sto[p]\n"
      printf ":: Help   : Try passing s, e, d, t, or p instead"
      return
    }
  }
}

def erika-wifi [action: string, ssid?: string] {
  match $action {
    "c" => {
      if ($ssid == null) {
        printf ":: Error  : Required [ssid] can not be empty while [action]: [c]onnect"
        return
      } else {
        nmcli device wifi connect $ssid --ask
      }
    },
    "l" => { nmcli device wifi list },
    "r" => { nmcli device wifi rescan },
    _ => {
      printf ":: Error  : Unknown [action]: '%s'\n" $action
      printf ":: Usage  : erika-wifi [action] [ssid?]\n"
      printf ":: Action : [c]onnect, [l]ist, [r]escan\n"
      printf ":: Help   : Try passing c, l, or r instead"
      return
    }
  }
}

def cfsync [] {
  if (is-admin) {
    print "You are not supposed to run this."
    return
  } else {
    cd ($env.HOME)/Projects/cfsync/
    just sync
    cd -
  }
}

def cfcopy [] {
  if (is-admin) {
    print "You are not supposed to run this."
    return
  } else {
    cd ($env.HOME)/Projects/cfsync/
    just copy
    cd -
  }
}

def push [] {
  git push; git push --all gitlab
}

def commit [message: string, push?: string] {
  match $push {
    "push" => {
      git add .
      git commit -m $message
      push
    },
    _ => {
      git add .
      git commit -m $message
    }
  }
}

# Aliases

alias a = erika-serv
alias c = clear
alias d = rm -rf
alias grep = grep --color=auto
alias i = erika-install
alias l = ls -la
alias q = erika-query
alias r = erika-remove
alias s = erika-sync
alias v = nvim
alias w = erika-wifi
alias x = exit
alias cn = config nu
alias ce = config env

# Other Aliases

alias crun = cargo run
alias cbuild = cargo build
alias ctest = cargo test

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

source ~/.zoxide.nu
