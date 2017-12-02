install:
	echo "installing deps"
	sudo pacman -S redshift
	
	echo "Setting up X11 ..."
	touch ~/.Xresources # at the moment the file is empty
	ln -s $(PWD)/X11/.xinitrc ~/.xinitrc
	
	echo "Setting up Redshit ..."
	ln -s $(PWD)/X11/redshift.conf ~/.config/redshift.conf

clean:
	rm ~/.xinitrc
	rm ~/.Xresources
	rm ~/.config/redshift.conf
