command --query nvim && set --export EDITOR nvim || set --export EDITOR vim

command --query firefox && set --export BROWSER firefox
command --query pgrep && pgrep chromium >/dev/null && set --export BROWSER chromium

set --export TIME_STYLE long-iso

set --erase SSH_AGENT_PID
set --export SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
