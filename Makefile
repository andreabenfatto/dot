install:
	echo "Setting up X11 ..."
	ln -s $(PWD)/X11/.xinitrc ~/.xinitrc

clean:
	rm ~/.xinitrc
