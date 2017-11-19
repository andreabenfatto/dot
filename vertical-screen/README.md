# Vertical screen

## Framebuffer mode

### Ideal solution
My setup is usually a single vertical screen. To make use of the vertical layout in framebuffer mode without using a custom kernel (see solution at the end of this doc)

This solutions didn't work out for me because I'm using a standard kernel.

It's possible, with `grub` or `systemd-boot`, to pass a parameter to the kernel to set the display orientation.
Documentation can be found in `/usr/src/linux/Documentation/fb/fbcon.txt`

	fbcon=rotate:<n>
 	
	        This option changes the orientation angle of the console display. The value 'n' accepts the following:
 	
	        0 - normal orientation (0 degree)
	        1 - clockwise orientation (90 degrees)
	        2 - upside down orientation (180 degrees)
	        3 - counterclockwise orientation (270 degrees)

For example in my case, using my DELL 2007FB, the setting should be `fbcon=rotate:3`

Just for the sake of documentation this is the setting to enable to the kernel:
```
    Device Drivers  --->
	    Graphics support  --->
	        Console display driver support  --->
	            [*] Framebuffer Console Rotation
```

Because it's since the university I don't recompile a kernel and I didn't wanted to investigate other solutions that Archlinux may provide, I decide do just create a simple systemd service to load at boot time.

### My FB solution using a service.

I create this file `/etc/systemd/system/display-rotate.service`
```
[Unit]
Description=Rotate display 90degrees counterclockwise

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/sh -c '/bin/echo 3 | /bin/tee /sys/class/graphics/fbcon/rotate_all'
ExecStop=/bin/sh -c '/bin/echo 1 | /bin/tee /sys/class/graphics/fbcon/rotate_all'

[Install]
WantedBy=multi-user.target
```

Enabled and loaded ;)

See [Archlinux doc about systemd](https://wiki.archlinux.org/index.php/systemd#Writing_unit_files).

In the service file you may notice that I create also the `ExecStop` target. I did it because in case I may use the same configuration with a second display (orizontal) it will be handy to change the orientation.


## X11 mode

### Randr command

Basically I set in my `.xinit` file the following:

```
##Rotate display 90 degrees counterclockwise
xrandr --output HDMI1 --auto --rotate left &
```
