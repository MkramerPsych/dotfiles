git clone --bare git@github.com:MkramerPsych/dotfiles.git $HOME/.dots
function config {
   /usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME $@
}
mkdir -p .dots-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dots-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
