
vars=".vimrc .gitconfig .vim .tmux.conf"

for file in $vars;
do
	mv -i $HOME/$file $HOME/dotfiles/$file
	ln -s $HOME/dotfiles/$file $HOME/$file
done
