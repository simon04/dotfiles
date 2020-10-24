if test -x /usr/bin/nvim
  set --export EDITOR nvim
else
  set --export EDITOR vim
end

set --export TIME_STYLE long-iso

set --erase SSH_AGENT_PID
set --export SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
