$env.STARSHIP_SHELL = "nu"

def left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

$env.PROMPT_COMMAND = { || left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

zoxide init nushell | save -f ~/.zoxide.nu

$env.JAVA_HOME = '/usr/lib/jvm/java-24-openjdk'
$env.PATH = ($env.PATH | prepend ($env.JAVA_HOME + '/bin'))
