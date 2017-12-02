package-list-gen:
	pacman -Qqe | grep -Fvx "$(pacman -Qqm)" > $(PWD)/pacman/archlinux-packages.txt

package-list-install:
	-xargs pacman -S --needed --noconfirm < pacman/archlinux-packages.txt
	@echo "Verify which packages require the manual installation from AUR"

install:
	echo "installing deps"
	
	echo "Setting up X11 ..."
	touch ~/.Xresources # at the moment the file is empty
	ln -s $(PWD)/X11/.xinitrc ~/.xinitrc
	
	echo "Setting up Redshit ..."
	ln -s $(PWD)/X11/redshift.conf ~/.config/redshift.conf
	
	echo "Setting up Polybar ..."
	mkdir -p ~/.config/polybar
	ln -s $(PWD)/polybar/config ~/.config/polybar/config
	ln -s $(PWD)/polybar/launch.sh ~/.config/polybar/launch.sh
	
	echo "Setting up i3 ..."
	ln -s $(PWD)/i3/config ~/.config/i3/config
	
	echo "Setting up wallpaper ..."
	mkdir -p ~/pictures
	ln -s $(PWD)/wallpapers/wallpaper.jpg ~/pictures/wallpaper.jpg	

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
	echo "Cleaning up ..."
	-rm ~/.xinitrc
	-rm ~/.Xresources
	-rm ~/.config/redshift.conf
	-rm ~/.config/polybar/config
	-rm ~/.config/polybar/launch.sh
	-rm ~/.config/i3/config
	-rm ~/pictures/wallpaper.jpg

clean-ssh:
	echo "Removing SSH Agent service"
	-systemctl --user stop ssh-agent.service
	-systemctl --user disable ssh-agent.service
	-rm ~/.config/systemd/user/ssh-agent.service
	-rm ~/.pam_environment

clean-fish:
	omf destroy
	-rm ~/.config/fish/config.fish
