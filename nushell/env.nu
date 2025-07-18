$env.CFG = $'($env.HOME)/.config'

$env.EDITOR = 'nvim'
$env.config.show_banner = false

def left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

$env.STARSHIP_SHELL = 'nu'
$env.PROMPT_COMMAND = { || left_prompt }
$env.PROMPT_COMMAND_RIGHT = ''
$env.PROMPT_INDICATOR = ''
$env.PROMPT_INDICATOR_VI_INSERT = ': '
$env.PROMPT_INDICATOR_VI_NORMAL = '〉'
$env.PROMPT_MULTILINE_INDICATOR = '::: '

$env.JAVA_HOME = '/usr/lib/jvm/java-24-openjdk'
$env.PATH = ($env.PATH | prepend ($env.JAVA_HOME + '/bin'))

zoxide init nushell | save -f ~/.zoxide.nu
