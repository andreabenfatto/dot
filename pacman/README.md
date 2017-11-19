# Pacman packages

In the directory there is an export of the explicit installed packages [archlinux-packages.txt](archlinux-packages.txt).

Here the commands to export the list of packages and to eventually reinstall them which I found (here)[https://bbs.archlinux.org/viewtopic.php?pid=735455#p735455].

```
# put all explicitly installed packages (minus AUR) into a file
# can be run as user
pacman -Qqe | grep -Fvx "$(pacman -Qqm)" > ./file

# reinstall from said file (deps will be pulled in automatically)
# must run as root
xargs pacman -S --needed --noconfirm < ./file
```
