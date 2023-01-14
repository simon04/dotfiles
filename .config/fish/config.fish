function setenv; set -gx $argv; end
source .env

command --query nvim && set --export EDITOR nvim || set --export EDITOR vim

command --query firefox && set --export BROWSER firefox
command --query pgrep && pgrep chromium >/dev/null && set --export BROWSER chromium
command --query pgrep && pgrep microsoft-edge >/dev/null && set --export BROWSER microsoft-edge
command --query pgrep && pgrep msedge >/dev/null && set --export BROWSER msedge

set --erase SSH_AGENT_PID
set --export SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
