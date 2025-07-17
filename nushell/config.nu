$env.config.show_banner = false
$env.EDITOR = "nvim"

def update_system [] {
  echo "updating :: system"
  aura -Syu
  echo "updating :: aur"
  aura -Ayu
  echo "updating :: snap"
  sudo snap refresh
  echo "updating :: flatpak"
  flatpak update
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
alias l = ls -la
alias u = update_system
alias grep = grep --color

source ~/.zoxide.nu
