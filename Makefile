install:
	echo "installing deps"
	sudo pacman -S redshift
	
	echo "Setting up X11 ..."
	touch ~/.Xresources # at the moment the file is empty
	ln -s $(PWD)/X11/.xinitrc ~/.xinitrc
	
	echo "Setting up Redshit ..."
	ln -s $(PWD)/X11/redshift.conf ~/.config/redshift.conf
	
	echo "Setting up Polybar ..."
	mkdir ~/.config/polybar
	ln -s $(PWD)/polybar/config ~/.config/polybar/config
	ln -s $(PWD)/polybar/launch.sh ~/.config/polybar/launch.sh

	
install-ssh:	# SSH Agent setup
	echo "Setting up SSH Agent service"
	mkdir -p ~/.config/systemd/user/
	ln -s $(PWD)/ssh-agent/ssh-agent.service ~/.config/systemd/user/ssh-agent.service
	ln -s $(PWD)/ssh-agent/.pan_environment ~/.pam_environment
	systemctl --user enable ssh-agent.service
	systemctl --user start ssh-agent.service

install-fish:
	echo "Setting up Fish ..."
	curl -L https://get.oh-my.fish | fish
	ln -s $(PWD)/fish/config.fish ~/.config/fish/config.fish
	omf install bobthefish

clean:
	rm ~/.xinitrc
	rm ~/.Xresources
	rm ~/.config/redshift.conf
	rm ~/.config/polybar/config
	rm ~/.config/polybar/launch.sh

clean-ssh:
	echo "Removing SSH Agent service"
	-systemctl --user stop ssh-agent.service
	-systemctl --user disable ssh-agent.service
	-rm ~/.config/systemd/user/ssh-agent.service
	-rm ~/.pam_environment

clean-fish:
	omf destroy
	-rm ~/.config/fish/config.fish
