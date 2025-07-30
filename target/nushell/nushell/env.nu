$env.CFG = $'($env.HOME)/.config'

$env.EDITOR = 'nvim'
$env.config.show_banner = false

$env.COSMIC_DATA_CONTROL_ENABLED = true

$env.JAVA_HOME = '/usr/lib/jvm/java-24-openjdk'
$env.PATH = ($env.PATH | prepend ($env.JAVA_HOME + '/bin'))

zoxide init nushell | save -f ~/.zoxide.nu
