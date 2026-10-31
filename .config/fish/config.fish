function setenv; set -gx $argv; end
source $HOME/.env

command --query nvim && set --export EDITOR nvim || set --export EDITOR vim

command --query firefox && set --export BROWSER firefox
command --query pgrep && pgrep chromium >/dev/null && set --export BROWSER chromium
command --query pgrep && pgrep microsoft-edge >/dev/null && set --export BROWSER microsoft-edge
command --query pgrep && pgrep msedge >/dev/null && set --export BROWSER msedge

if command --query mise
    if status is-interactive
        mise activate fish | source
    else
        mise activate fish --shims | source
    end
end
