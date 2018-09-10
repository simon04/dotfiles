if test -x /usr/bin/nvim
  set --export EDITOR nvim
else
  set --export EDITOR vim
end

set --export FZF_DEFAULT_OPTS "--bind='ctrl-o:execute(code {})+abort'"
set --export FZF_CTRL_T_OPTS "--preview 'bat {}'"
set --export FZF_DEFAULT_COMMAND "fd --max-depth 3"
set --export FZF_ALT_C_COMMAND "fd --max-depth 3"
