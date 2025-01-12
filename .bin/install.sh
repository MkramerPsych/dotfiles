# Step 1: Determine the appropriate shell configuration file
if [[ $SHELL == *"bash" ]]; then
  SHELL_RC="$HOME/.bashrc"
elif [[ $SHELL == *"zsh" ]]; then
  SHELL_RC="$HOME/.zshrc"
else
  echo "Unsupported shell. Please use bash or zsh."
  exit 1
fi

# Create an alias for 'config' and store it in the appropriate configuration file
echo "alias config='/usr/bin/git --git-dir=\$HOME/.dots/ --work-tree=\$HOME'" >> "$SHELL_RC"
echo "Added config alias to $SHELL_RC."

# Step 2: Create .gitignore and add .dots to it
echo ".dots" >> $HOME/.gitignore
echo "Added .dots to .gitignore."

# Step 3: Clone the bare repository
git clone --bare git@github.com:MkramerPsych/dotfiles.git $HOME/.dots

# Step 4: Define the 'config' function
function config {
   /usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME $@
}

# Step 5: Create a backup directory
mkdir -p .dots-backup

# Step 6: Attempt to check out the repository
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
else
  echo "Backing up pre-existing dot files.";
  config checkout 2>&1 | egrep "\s+\." | awk '{print $1}' | \
  xargs -I{} sh -c 'mkdir -p $(dirname .dots-backup/{}) && mv {} .dots-backup/{}'
fi

# Step 7: Finalize the checkout and configure Git
config checkout
config config status.showUntrackedFiles no

# Step 8: Print a success message
echo "Dotfiles setup completed successfully! Remember to source your $SHELL_RC or restart your shell for changes to take effect."
