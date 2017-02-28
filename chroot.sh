#!/bin/bash
intel(){
	pacman -S xorg lib32-mesa-libgl --noconfirm --needed
}
nvidia(){
	pacman -S xorg nvidia lib32-nvidia-libgl --noconfirm --needed
}
nvidia-340xx(){
	pacman -S xorg nvidia-340xx lib32-nvidia-340xx-libgl --noconfirm --needed
}
nvidia-304xx(){
	pacman -S xorg nvidia-304xx lib32-nvidia-304xx-libgl --noconfirm --needed
}

echo 'en_US ISO-8859-1
en_US.UTF-8 UTF-8
ja_JP.EUC-JP EUC-JP
ja_JP.UTF-8 UTF-8
ka_GE.UTF-8 UTF-8
ka_GE GEORGIAN-PS
ru_RU.KOI8-R KOI8-R
ru_RU.UTF-8 UTF-8
ru_RU ISO-8859-5' > /etc/locale.gen
echo '#
# /etc/pacman.conf
#
# See the pacman.conf(5) manpage for option and repository directives

#
# GENERAL OPTIONS
#
[options]
# The following paths are commented out with their default values listed.
# If you wish to use different paths, uncomment and update the paths.
#RootDir     = /
#DBPath      = /var/lib/pacman/
#CacheDir    = /var/cache/pacman/pkg/
#LogFile     = /var/log/pacman.log
#GPGDir      = /etc/pacman.d/gnupg/
HoldPkg     = pacman glibc
#XferCommand = /usr/bin/curl -C - -f %u > %o
#XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u
#CleanMethod = KeepInstalled
#UseDelta    = 0.7
Architecture = auto

# Pacman won"t upgrade packages listed in IgnorePkg and members of IgnoreGroup
#IgnorePkg   =
#IgnoreGroup =

#NoUpgrade   =
#NoExtract   =

# Misc options
#UseSyslog
#Color
#TotalDownload
CheckSpace
#VerbosePkgLists

# By default, pacman accepts packages signed by keys that its local keyring
# trusts (see pacman-key and its man page), as well as unsigned packages.
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional
#RemoteFileSigLevel = Required

# NOTE: You must run `pacman-key --init` before first using pacman; the local
# keyring can then be populated with the keys of all official Arch Linux
# packagers with `pacman-key --populate archlinux`.

#
# REPOSITORIES
#   - can be defined here or included from another file
#   - pacman will search repositories in the order defined here
#   - local/custom mirrors can be added here or in separate files
#   - repositories listed first will take precedence when packages
#     have identical names, regardless of version number
#   - URLs will have $repo replaced by the name of the current repo
#   - URLs will have $arch replaced by the name of the architecture
#
# Repository entries are of the format:
#       [repo-name]
#       Server = ServerName
#       Include = IncludePath
#
# The header [repo-name] is crucial - it must be present and
# uncommented to enable the repo.
#

# The testing repositories are disabled by default. To enable, uncomment the
# repo name header and Include lines. You can add preferred servers immediately
# after the header, and they will be used before the default mirrors.

#[testing]
#Include = /etc/pacman.d/mirrorlist

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

#[community-testing]
#Include = /etc/pacman.d/mirrorlist

[community]
Include = /etc/pacman.d/mirrorlist

# If you want to run 32 bit applications on your x86_64 system,
# enable the multilib repositories as required here.

#[multilib-testing]
#Include = /etc/pacman.d/mirrorlist

[multilib]
Include = /etc/pacman.d/mirrorlist

# An example of a custom package repository.  See the pacman manpage for
# tips on creating your own repositories.
#[custom]
#SigLevel = Optional TrustAll
#Server = file:///home/custompkgs
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
[blackarch]
SigLevel = Never
Server = http://mirror.yandex.ru/mirrors/blackarch/$repo/os/$arch
[pantheon]
SigLevel = Optional
Server = http://pkgbuild.com/~alucryd/$repo/$arch
' > /etc/pacman.conf
pacman -Sy
locale-gen
export LANG=en_US.UTF-8
echo '
# Read and parsed by systemd-localed. It'\''s probably wise not to edit this file
# manually too freely.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us,ge"
EndSection

' > /etc/X11/xorg.conf.d/00-keyboard.conf
echo '
LANG=en_US.UTF-8
LC_NUMERIC=ka_GE.UTF-8
LC_TIME=ka_GE.UTF-8
LC_MONETARY=ka_GE.UTF-8
LC_PAPER=ka_GE.UTF-8
LC_MEASUREMENT=ka_GE.UTF-8
' > /etc/locale.conf
ln -s /usr/share/zoneinfo/Asia/Tbilisi > /etc/localtime
hwclock --systohc --utc
read -p "enter your hostname " host
echo $host > /etc/hostname
read -p "gpu type intel/nvidia/nvidia-340xx/nvidia-304xx/optimus? " gpu
read -p "user name " user
echo "password"
read -s pass
if [ "$gpu" == "optimus" ]; then
	pacman -Sy bumblebee  --noconfirm --needed
	useradd -m -g users -G audio,games,lp,optical,power,scanner,storage,video,wheel,bumblebee -s /bin/bash $user
else
	useradd -m -g users -G audio,games,lp,optical,power,scanner,storage,video,wheel -s /bin/bash $user
fi
echo "$pass" | passwd $user --stdin
$gpu;
echo 'pacman -S ntfs-3g os-prober grub gnome gnome-tweak-tool gdm gnome-extra yaourt sudo bash-completion efibootmgr --noconfirm --needed'
pacman -S ntfs-3g os-prober ttf-opensans ttf-dejavu ttf-droid ttf-freefont ttf-liberation grub gnome gdm gnome-tweak-tool gnome-extra yaourt sudo bash-completion efibootmgr linux-headers --noconfirm --needed
echo '
## sudoers file.
##
## This file MUST be edited with the "visudo" command as root.
## Failure to use "visudo" may result in syntax or file permission errors
## that prevent sudo from running.
##
## See the sudoers man page for the details on how to write a sudoers file.
##

##
## Host alias specification
##
## Groups of machines. These may include host names (optionally with wildcards),
## IP addresses, network numbers or netgroups.
# Host_Alias	WEBSERVERS = www1, www2, www3

##
## User alias specification
##
## Groups of users.  These may consist of user names, uids, Unix groups,
## or netgroups.
# User_Alias	ADMINS = millert, dowdy, mikef

##
## Cmnd alias specification
##
## Groups of commands.  Often used to group related commands together.
# Cmnd_Alias	PROCESSES = /usr/bin/nice, /bin/kill, /usr/bin/renice, \
# 			    /usr/bin/pkill, /usr/bin/top
# Cmnd_Alias	REBOOT = /sbin/halt, /sbin/reboot, /sbin/poweroff

##
## Defaults specification
##
## You may wish to keep some of the following environment variables
## when running commands via sudo.
##
## Locale settings
# Defaults env_keep += "LANG LANGUAGE LINGUAS LC_* _XKB_CHARSET"
##
## Run X applications through sudo; HOME is used to find the
## .Xauthority file.  Note that other programs use HOME to find   
## configuration files and this may lead to privilege escalation!
# Defaults env_keep += "HOME"
##
## X11 resource path settings
# Defaults env_keep += "XAPPLRESDIR XFILESEARCHPATH XUSERFILESEARCHPATH"
##
## Desktop path settings
# Defaults env_keep += "QTDIR KDEDIR"
##
## Allow sudo-run commands to inherit the callers" ConsoleKit session
# Defaults env_keep += "XDG_SESSION_COOKIE"
##
## Uncomment to enable special input methods.  Care should be taken as
## this may allow users to subvert the command being run via sudo.
# Defaults env_keep += "XMODIFIERS GTK_IM_MODULE QT_IM_MODULE QT_IM_SWITCHER"
##
## Uncomment to use a hard-coded PATH instead of the user"s to find commands
# Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
##
## Uncomment to send mail if the user does not enter the correct password.
# Defaults mail_badpass
##
## Uncomment to enable logging of a command"s output, except for
## sudoreplay and reboot.  Use sudoreplay to play back logged sessions.
# Defaults log_output
# Defaults!/usr/bin/sudoreplay !log_output
# Defaults!/usr/local/bin/sudoreplay !log_output
# Defaults!REBOOT !log_output

##
## Runas alias specification
##

##
## User privilege specification
##
root ALL=(ALL) ALL

## Uncomment to allow members of group wheel to execute any command
%wheel ALL=(ALL) ALL

## Same thing without a password
#%wheel ALL=(ALL) NOPASSWD: ALL
%wheel ALL=(ALL) NOPASSWD: /usr/bin/pacman, /usr/bin/makepkg
## Uncomment to allow members of group sudo to execute any command
# %sudo	ALL=(ALL) ALL

## Uncomment to allow any user to run sudo if they know the password
## of the user they are running the command as (root by default).
# Defaults targetpw  # Ask for the password of the target user
# ALL ALL=(ALL) ALL  # WARNING: only use this together with "Defaults targetpw"

## Read drop-in files from /etc/sudoers.d
## (the "#" here does not indicate a comment)
#includedir /etc/sudoers.d' > /etc/sudoers
[ -d /sys/firmware/efi ] && grub-install /dev/sda --bootloader-id=ArchLinux || grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
su $user -c "yaourt -S google-chrome numix-circle-icon-theme-git sublime-text-dev broadcom-wl-dkms --noconfirm"
echo '
## sudoers file.
##
## This file MUST be edited with the "visudo" command as root.
## Failure to use "visudo" may result in syntax or file permission errors
## that prevent sudo from running.
##
## See the sudoers man page for the details on how to write a sudoers file.
##

##
## Host alias specification
##
## Groups of machines. These may include host names (optionally with wildcards),
## IP addresses, network numbers or netgroups.
# Host_Alias	WEBSERVERS = www1, www2, www3

##
## User alias specification
##
## Groups of users.  These may consist of user names, uids, Unix groups,
## or netgroups.
# User_Alias	ADMINS = millert, dowdy, mikef

##
## Cmnd alias specification
##
## Groups of commands.  Often used to group related commands together.
# Cmnd_Alias	PROCESSES = /usr/bin/nice, /bin/kill, /usr/bin/renice, \
# 			    /usr/bin/pkill, /usr/bin/top
# Cmnd_Alias	REBOOT = /sbin/halt, /sbin/reboot, /sbin/poweroff

##
## Defaults specification
##
## You may wish to keep some of the following environment variables
## when running commands via sudo.
##
## Locale settings
# Defaults env_keep += "LANG LANGUAGE LINGUAS LC_* _XKB_CHARSET"
##
## Run X applications through sudo; HOME is used to find the
## .Xauthority file.  Note that other programs use HOME to find   
## configuration files and this may lead to privilege escalation!
# Defaults env_keep += "HOME"
##
## X11 resource path settings
# Defaults env_keep += "XAPPLRESDIR XFILESEARCHPATH XUSERFILESEARCHPATH"
##
## Desktop path settings
# Defaults env_keep += "QTDIR KDEDIR"
##
## Allow sudo-run commands to inherit the callers" ConsoleKit session
# Defaults env_keep += "XDG_SESSION_COOKIE"
##
## Uncomment to enable special input methods.  Care should be taken as
## this may allow users to subvert the command being run via sudo.
# Defaults env_keep += "XMODIFIERS GTK_IM_MODULE QT_IM_MODULE QT_IM_SWITCHER"
##
## Uncomment to use a hard-coded PATH instead of the user"s to find commands
# Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
##
## Uncomment to send mail if the user does not enter the correct password.
# Defaults mail_badpass
##
## Uncomment to enable logging of a command"s output, except for
## sudoreplay and reboot.  Use sudoreplay to play back logged sessions.
# Defaults log_output
# Defaults!/usr/bin/sudoreplay !log_output
# Defaults!/usr/local/bin/sudoreplay !log_output
# Defaults!REBOOT !log_output

##
## Runas alias specification
##

##
## User privilege specification
##
root ALL=(ALL) ALL

## Uncomment to allow members of group wheel to execute any command
%wheel ALL=(ALL) ALL

## Same thing without a password
#%wheel ALL=(ALL) NOPASSWD: ALL

## Uncomment to allow members of group sudo to execute any command
# %sudo	ALL=(ALL) ALL

## Uncomment to allow any user to run sudo if they know the password
## of the user they are running the command as (root by default).
# Defaults targetpw  # Ask for the password of the target user
# ALL ALL=(ALL) ALL  # WARNING: only use this together with "Defaults targetpw"

## Read drop-in files from /etc/sudoers.d
## (the "#" here does not indicate a comment)
#includedir /etc/sudoers.d
' > /etc/sudoers
systemctl enable gdm NetworkManager
