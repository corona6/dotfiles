
vars=".vimrc .gitconfig"

for file in $vars;
do
	rm $HOME/$file
	ln -s $HOME/dotfiles/$file $HOME/$file
done
