
vars=".vimrc .gitconfig .vim .tmux.conf .tmux .zshrc"

for file in $vars;
do
	rm -i $HOME/$file
	ln -s $HOME/dotfiles/$file $HOME/$file
done
