
vars=".vimrc .gitconfig"

for file in $vars;
do
	mv $HOME/$file $HOME/dotfiles/$file
	ln -s $HOME/dotfiles/$file $HOME/$file
done
