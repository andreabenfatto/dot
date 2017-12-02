install:
	echo "installing deps"
	sudo pacman -S redshift
	
	echo "Setting up X11 ..."
	touch ~/.Xresources # at the moment the file is empty
	ln -s $(PWD)/X11/.xinitrc ~/.xinitrc
	
	echo "Setting up Redshit ..."
	ln -s $(PWD)/X11/redshift.conf ~/.config/redshift.conf
	
install-ssh:	# SSH Agent setup
	echo "Setting up SSH Agent service"
	mkdir -p ~/.config/systemd/user/
	ln -s $(PWD)/ssh-agent/ssh-agent.service ~/.config/systemd/user/ssh-agent.service
	systemctl --user enable ssh-agent.service
	systemctl --user start ssh-agent.service

clean:
	rm ~/.xinitrc
	rm ~/.Xresources
	rm ~/.config/redshift.conf

clean-ssh:
	echo "Removing SSH Agent service"
	-systemctl --user stop ssh-agent.service
	-systemctl --user disable ssh-agent.service
	-rm ~/.config/systemd/user/ssh-agent.service
