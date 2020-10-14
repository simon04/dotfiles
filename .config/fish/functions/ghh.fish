function ghh --description 'Clones a git repository to src/' --argument repo
	set project (basename $repo)
  set destination $HOME/src/$project
  if test -d $destination
    cd $destination
  else
    gh repo clone $repo $destination
    cd $destination
  end
end
