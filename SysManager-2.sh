#!/usr/bin/env bash



# Declaring list of application from package managers and their category

#<pacman>

pacman_programing=(
    'kate'
    'android-tools'
    'atom'
    'codeblocks'
    'github-desktop'
    'vim'
    'mysql-workbench'
)

installing_additional_package_managers=(
    'flatpak'
)

pacman_gaming=(
    'discord'
    'discord-canary'
    'gamemode'
    'lutris'
    'steam'
    'steam-runtime'
)

pacman_emulation=(
    'dolphin-emu'

)

pacman_content_creation=(
    'blender'
    'darktable'
	'gimp'
	'inkscape'
	'obs-studio'
)

pacman_others=(
    'flameshot'
	'gnome-keyring'
	'gparted'
	'onboard'
	'okular'
	'qbittorent'
	'teamviewer'
	'tigervnc'
	'minder'
)

pacman_terminals=(
    'alacritty'
	'cool-retro-term'
	'kitty'
	'yakuke'
)

pacman_file_explorers=(
    'pcmanfm'
	'nautilus'
	'thunar'
	'pcmanfm'
	'mc' #midnight commander
	'fff'
	'krusader'
	'ranger'
)

pacman_browsers=(
    'chromium'
	'firefox'
	'librewolf'
	'opera'
	'vivaldi'
	'qutebrowser'
	'vimb'
)

pacman_rice=(
    'cmatrix'
	'conky-manager'
	'bpytop'
	'htop'
	'readeontop'
	'neofetch'
	'rofi'
	'vtop'
)

pacman_emulation=(
    'docker'
    #virtual box
    'virtualbox'
    'virtualbox-host-dkms'
)
#<yay>

yay_programing=(
    'mycli-git'
)

yay_gaming=(
    'playonlinux'
	'protontricks-git'
    'protonup-qt'
	'heroic-games-launcher-bin'
)

yay_package_managers=(
    'appimagelauncher'
	'aura-bin'
	'snapd'
	'pacfinder'
)

yay_rice=(
    'bash-pipes'
	'cava-git'
	'cbonsai-git'
	'pfetch-git'
	'tty-clock-git'
)

yay_others=(
    'freeoffice'
	'jamesdsp'
	'openrgb'
	'openrazer-meta'
	'polychromatic'
	'popsicle-git'
)

#<flatpak>

flatpak_programing=(
    'com.getpostman.Postman' #Postman
	'com.jetbrains.DataGrip' #Android Studio
	'com.jetbrains.DataGrip' #DataGrip,
	'com.jetbrains.IntelliJ-IDEA-Community' #IntelliJ IDEA Community
	'com.jetbrains.IntelliJ-IDEA-Ultimate' #IntelliJ IDEA Ultimate
	'com.sublimemerge.App'  #Sublime Merge,
	'com.sublimetext.three' #Sublime Text
	'org.codeblocks.codeblocks' #Code::Blocks,
	'org.eclipse.Javascript' #Eclipse IDE for Java Developers,
)

flatpak_gaming_and_emulation=(
    'org.libretro.RetroArch'  #RetroArch
	'org.polymc.PolyMC' #PolyMC
	'org.yuzu_emu.yuzu' #yuzu
	'com.usebottles.bottles' #Bottles
	'net.pcsx2.PCSX2' #PCSX2 ps2 emulator
	'net.rpcs3.RPCS3' #RPCS3 ps3 emulator
)

flatpak_content_creation=(
    'com.github.libresprite.LibreSprite' #LibreSprite
	'com.obsproject.Studio' #OBS Studio
	'net.blockbench.Blockbench' #Blockbench
)

flatpak_others=(
    'com.github.alainm23.planner' #Planner
	'com.github.tchx84.Flatseal' #Flatseal
	'com.spotify.Client' #Spotify
	'net.sf.VICE' #VICE
	'org.filezillaproject.Filezilla' #FileZilla
	're.sonny.Tangram' #Tangram
	'md.obsidian.Obsidian' #productivity app and notes

)
#<snap>


#packages that needs multi step install
clear_terminal(){
    printf "\033c"
    #clear && echo -en "\e[3J" #if you are using Konsole terminal use this
}
doom_emacs_setup(){
    sudo pacman -S emacs
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
}

mariadb_setup(){
    sudo pacman -S mariadb
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    echo "Enabling mariadb.service \n\
    Run mysql -u root for using the database \n\
    Run mycli -u root for using the database with autocomplete "
}

yay_setup(){
    pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
}

virt_manager_qemu_setup(){
    depedencties=(
        'virt-manager'
        'qemu'
        'archlinux-keyring'
        'virt-viewer'
        'dnsmasq'
        'vd2'
        'bridge-utils'
        'openbsd-netcat'
        'ebtables'
        'iptables'
        'libguestfs'
        )

    for PKG in "${depedencties[@]}"; do
        echo "Installing: ${PKG} "
        sudo pacman -S "$PKG" --noconfirm --needed
     done

}

# Global functions

pacman_install(){
    package=$1
    sudo pacman -S "@package"
}

pacman_install_list(){
    arr=("$@")
    for i in "${arr[@]}";do
		sudo pacman -S "$i"
	done

}

pacman_remove(){
    package=$1
    sudo pacman -Rnsd "@package"
}

pacman_remove_list(){
    arr=("$@")
    for i in "${arr[@]}";do
		sudo pacman -Rnsd "$i"
	done
}

flatpak_install(){
    package=$1
    flatpak install "$package"
}

flatpak_install_list(){
    arr=("$@")
    for i in "${arr[@]}";do
		flatpak install "$i"
	done
}

flatpak_remove(){
    package=$1
    flatpak remove "$package"
}

flatpak_remove_list(){
    arr=("$@")
    for i in "${arr[@]}";do
		flatpak remove "$i"
	done
}

yay_install(){
    package=$1
    yay -S "@package"
}

yay_install_lists(){
    arr=("$@")
    for i in "${arr[@]}";do
		yay -S "$i"
	done
}

yay_remove(){
    package=$1
    yay -Rnsd "@package"
}

yay_remove_list(){
    arr=("$@")
    for i in "${arr[@]}";do
		yay -Rnsd "$i"
	done
}

snap_install(){
    package=$1
    snap install "@package"
}

snap_install_list(){
    arr=("$@")
    for i in "${arr[@]}";do
		snap install "$i"
	done
}

snap_remove(){
    package=$1
    snap uninstall "@package"
}

snap_remove_list(){
    arr=("$@")
    for i in "${arr[@]}";do
		snap uninstall "$i"
	done
}
# Makeing the menus and functions


# ===<Desktop enviroment & window managers menu>===

ofde_menu(){
 echo "

 Disclaimer: for informations about the DE see arch wiki.
------------------------------------------------------------------
|1) Budgie                                                       |
|2) Cinnamon                                                     |
|3) Cutefish                                                     |
|4) Deepin                                                       |
|5) Enlightenment                                                |
|6) Gnome                                                        |
|7) Gnome Flashback                                              |
|8) KDE                                                          |
|9) LXDE                                                         |
|10) LXQT                                                        |
|11) MATE                                                        |
|12) Sugar                                                       |
|13) Ukui                                                        |
|14) XFCE                                                        |
|15) Back                                                        |
|16) Main menu                                                   |
|17) Exit                                                        |
------------------------------------------------------------------
What?:
"
 read a
 case $a in
     1) clear_terminal ; pacman_install "budgie-desktop" ; ofde_menu ;;
     2) clear_terminal ; pacman_install "cinnamon" ; ofde_menu ;;
     3) clear_terminal ; pacman_install "cutefish" ; ofde_menu ;;
     4) clear_terminal ; pacman_install "deepin" ; ofde_menu ;;
     5) clear_terminal ; pacman_install "enlightenment" ; ofde_menu ;;
     6) clear_terminal ; pacman_install "gnome" ; ofde_menu ;;
     7) clear_terminal ; pacman_install "gnome-flashback" ; ofde_menu ;;
     8) clear_terminal ; pacman_install "plasma" ; ofde_menu ;;
     9) clear_terminal ; pacman_install "lxde-gtk3" ; ofde_menu ;;
     10) clear_terminal ; pacman_install "lxqt" ; ofde_menu ;;
     11) clear_terminal ; pacman_install "mate" ; ofde_menu ;;
     12) clear_terminal ; pacman_install "sugar sugar-fructose" ; ofde_menu ;;
     13) clear_terminal ; pacman_install "ukui" ; ofde_menu ;;
     14) clear_terminal ; pacman_install "xfce4" ; ofde_menu ;;
     15) clear_terminal ; de_wm_menu ;;
     16) clear_terminal ; menu ;;
     17) exit 0 ;;
 esac
}
usde_menu(){
    echo "
Disclaimer: for informations about the DE see arch wiki.
-------------------------------------------------
|1)CDE                                          |
|2)EDE                                          |
|3)KDE 1                                        |
|4)Liri                                         |
|5)Lumina                                       |
|6)Moksha                                       |
|7)Pantheon                                     |
|8)PaperDE                                      |
|9)Phosh                                        |
|10)TheDesk                                     |
|11)Trinity                                     |
|12)Back                                        |
|13)Main menu                                   |
|14)Exit                                        |
-------------------------------------------------
What?:
"
    read a
    case $a in
        1) clear_terminal ; yay_install "cdesktopenv" ; usde_menu ;;
        2) clear_terminal ; yay_install "ede" ; usde_menu ;;
        3) clear_terminal ; yay_install "kde1-kdebase-git" ; usde_menu ;;
        4) clear_terminal ; yay_install "liri-shell-git" ; usde_menu ;;
        5) clear_terminal ; yay_install "lumina-desktop" ; usde_menu ;;
        6) clear_terminal ; yay_install "moksha-git" ; usde_menu ;;
        7) clear_terminal ; yay_install "pantheon-session-git" ; usde_menu ;;
        8) clear_terminal ; yay_install "paperde" ; usde_menu ;;
        9) clear_terminal ; yay_install "phosh-git" ; usde_menu ;;
        10) clear_terminal ; yay_install "thedesk" ; usde_menu ;;
        11) clear_terminal ; yay_install "trinity" ; usde_menu ;;
        12) clear_terminal ; de_wm_menu ;;
        13) clear_terminal ; menu ;;
        14) exit 0 ;;
    esac
}
owm_menu(){
    echo "
    Disclaimer: you will need to searh yourself
        for the informations about the WM's.
--------------------------------------------------
|1) i3                                           |
|2) Qtile                                        |
|3) Awesome                                      |
|4) Xmonad                                       |
|5) Openbox                                      |
|6) Back                                         |
|7) Main menu                                    |
|8) Exit                                         |
--------------------------------------------------
What?:
"
    read a
    case $a in
        1) clear_terminal ; pacman_install "i3-gaps polybar" ; owm_menu ;;
        2) clear_terminal ; pacman_install "qtile" ; owm_menu ;;
        3) clear_terminal ; pacman_install "awesome" ; owm_menu ;;
        4) clear_terminal ; pacman_install "xmonad xmonad-contrib xmonad-utils" ; owm_menu ;;
        5) clear_terminal ; pacman_install "openbox ttf-dejavu ttf-liberatio" ; owm_menu ;;
        6) clear_terminal ; install_menu ;;
        7) clear_terminal ; menu ;;
        8) exit 0 ;;
    esac
}

de_wm_menu(){
    echo "
--------------------------------------------------
|1) Official supported desktop enviroment        |
|2) Unofficial supported desktop enviroment      |
|3) Tiling window managers                       |
|4) Back                                         |
|5) Main menu                                    |
|6) Exit                                         |
--------------------------------------------------
What?:
"
    read a
    case $a in
        1) clear_terminal ; ofde_menu ;;
        2) clear_terminal ; usde_menu ;;
        3) clear_terminal ; owm_menu ;;
        4) clear_terminal ; install_menu ;;
        5) clear_terminal ; menu ;;
        6) exit 0 ;;
    esac
}

# =================================================

# ===<Installer menu>===

#<Post install>
minimal(){
    PKGS=(
        'firefox' #browser
        'alacritty' #terminal
        'dolphin' #file manager
        #'thunar' #file manager
        'flatpak'
        'lightdm'
        'lightdm-gtk-greeter'
        'htop'
        'neofetch'
        'xorg-server'
    )
    for PKG in "${PKGS[@]}"; do
      echo "Installing: ${PKG} via pacman"
      sudo pacman -S "${PKG}" --noconfirm --needed
    done
    #enabling services
    sudo systemctl enable lightdm.service
}


normal(){
    echo "Installing yay AUR package manager...."
    sudo pacman -S git
    PPKGS=(
        'firefox' #browser default
        'alacritty' #default terminal
        'dolphin' #default file manager
        #'thunar' #file manager
        'engrampa' #archive manager
        'vlc' #video player
        'nomacs' #image viewer
        #'feh' #image viewer
        'audacious' #audio player
        'neofetch'
        'htop' #terminal task manager
        'xrandr' #screen resolution manager
        'nitrogen' #teminal background manager
        #'picom' #compositor
        'xorg-xinput' #xorg input manager
        'popsicle' #usb flasher for linux(curently windows iso not suported)
        'libreoffice'
        'calibre'
        'flameshot'
        'onboard'
        'qbittorrent'
        #'redshift'
        'lightdm' #login manager
        'lightdm-gtk-greeter'

    )
    for PPKG in "${PPKGS[@]}"; do
        echo "Installing: ${PPKG} via pacman"
        sudo pacman -S "$PPKG" --noconfirm --needed
    done
    #enabling services
    sudo systemctl enable lightdm.service

}

#package_managers_menu(){}

#gaming_menu(){}

#content_creation_menu(){}

#virtualiation_menu(){}

#programing_menu(){}

#terminals_menu(){}

#browsers_menu(){}

#rice_menu(){}

#productivity_menu(){}


install_menu(){
    echo "
-------------------------------------------------
|1) Desktop Enviroment & Window managers menu   |
|2) Minimal instalation                         |
|3) Normal instalation                          |
|4) Package managers(yay,flatpak,snap)          |
|5) Gaming apps                                 |
|6) Content creation apps                       |
|7) Virtualization Apps                         |
|8) Programing Apps                             |
|9) Terminals                                   |
|10) Browsers                                   |
|11) Linux Rice                                 |
|12) Productivity                               |
|13) Back                                       |
|14) Main menu                                  |
|15) Exit                                       |
-------------------------------------------------
What?:
"
    read a
    case $a in
        1) clear_terminal ; de_wm_menu;;
        2) clear_terminal ; minimal ; install_menu ;;
        3) clear_terminal ; normal ; install_menu ;;
        4) clear_terminal ; package_managers ; install_menu ;;
        5) clear_terminal ; gameing ; install_menu ;;
        6) clear_terminal ; art ; install_menu ;;
        7) clear_terminal ; virtualization ; install_menu ;;
        8) clear_terminal ; programing ; install_menu ;;
        9) clear_terminal ; terminals ; install_menu ;;
        10) clear_terminal ; browsers ; install_menu ;;
        11) clear_terminal ; unixporn ; install_menu ;;
        12) clear_terminal ; efficiency ; install_menu ;;
        13) clear_terminal ; system_menu ;;
        14) clear_terminal ; menu ;;
        15) exit 0 ;;
    esac

}

# ======================


# ===<System Maintanance menu>===

update_pacman(){
    echo "Running system update...."
    sudo pacman -Syyu
}

update_yay(){
    echo "Updating yay...."
    yay
}

update_flatpak(){
    echo "Updating flatpak...."
    sudo flatpak update
}

check_systemd(){
    echo "Checking systemd failed services...."
    systemctl --failed

}

log_files_check(){
    echo "Checking log files...."
    sudo journalctl -p 3 -xb
}

delete_pacman_cache(){
    echo "Deleting pacman cache...."
    sudo pacman -Scc
}

delete_yay_cache(){
    echo "Deleting yay cache...."
    yay -Scc
}

delete_unwanted_dependencies(){
    echo "Deleting unwated dependecies"
    yay -Yc
}

remove_orphan_packages(){
    echo "Removing orphan packages...."
    sudo aura -Oj
}

clean_cache(){
    echo "Cleaning Cache...."
    sudo rm -rf .cache/*
}

clean_journal(){
    echo "Cleaning Journal"
    sudo journalctl --vacuum-time=2weeks
}

disable_internal_keyboard(){
    xinput
    echo 'Look for  "↳ AT Translated Set 2 keyboard" to disable and enter his id:'
    read id
    xinput float $id
    echo "The internal keyboard was disabled"
}

enable_internal_keyboard(){
    xinput
    echo 'Look for  "↳ AT Translated Set 2 keyboard" to enable and enter his id:'
    read id
    echo 'now enter his master:'
    read master
    xinput float $id $master
    echo 'Internal keyboard now enabled'
}

system_maintanance_menu(){
    echo "
---------------------------------------------
|1) Update pacman                           |
|2) Update yay                              |
|3) Update flatpak                          |
|4) Check systemd                           |
|5) Log                                     |
|6) Delete pacman cache                     |
|7) Delete yay cache                        |
|8) Delete unwanted depedencies             |
|9) Delete orphan packages                  |
|10) Clean cache                            |
|11) Clean journal                          |
|12) Disable internal keyboard              |
|13) Enable internal keyboard               |
|14) Back                                   |
|15) Main menu                              |
|16) Exit                                   |
---------------------------------------------
What?:
"
    read a
    case $a in
        1) clear_terminal ; update_pacman; system_maintanance_menu ;;
        2) clear_terminal ; update_yay; system_maintanance_menu ;;
        3) clear_terminal ; update_flatpak; system_maintanance_menu ;;
        4) clear_terminal ; check_systemd; system_maintanance_menu ;;
        5) clear_terminal ; log_files_check; system_maintanance_menu ;;
        6) clear_terminal ; delete_pacman_cache; system_maintanance_menu ;;
        7) clear_terminal ; delete_yay_cache; system_maintanance_menu ;;
        8) clear_terminal ; delete_unwanted_dependencies; system_maintanance_menu ;;
        9) clear_terminal ; remove_orphan_packages; system_maintanance_menu ;;
        10) clear_terminal ; clean_cache; system_maintanance_menu ;;
        11) clear_terminal ; clean_journal ; system_maintanance_menu ;;
        12) clear_terminal ; disable_internal_keyboard ; system_maintanance_menu ;;
        13) clear_terminal ; enable_internal_keyboard ; system_maintanance_menu ;;
        14) clear_terminal ; system_menu ;;
        15) clear_terminal ; menu ;;
        16) exit 0 ;;
    esac
}

# ===============================

# ===<Battery charging limit menu>===


show_charging_limit(){
	cat /sys/class/power_supply/BAT0/charge_control_end_threshold
}

change_charging_limit_default(){

	if [[ $USER != "root" ]];
	then
		echo "Change user to root just for this operation and the switch back to regular user"
	else
		echo "Charging limit changed. Swith back to regular user."
		sudo echo 60 > /sys/class/power_supply/BAT0/charge_control_end_threshold
	fi

}

change_charging_limit_custom(){
	if [[ $USER != "root" ]];
	then
		echo "Change user to root just for this operation and the switch back to regular user"
	else
		echo "Enter the value(between 10-100%):"
		read ch
		sudo echo "${ch}" > /sys/class/power_supply/BAT0/charge_control_end_threshold
		echo "Charging limit changed. Swith back to regular user."
	fi

}

restore_charging_limit(){

	if [[ $USER != "root" ]];
	then
		echo "Change user to root just for this operation and the switch back to regular user"
	else
		echo "Charging limit changed. Swith back to regular user."
		sudo echo 100 > /sys/class/power_supply/BAT0/charge_control_end_threshold
	fi

}


battery_charge_limit_menu(){
	echo "
-------------------------------------------
|1) Show charging limit                   |
|2) Change charging limit(default 60%)    |
|3) Change charging limit(custom)		  |
|4) Restore to default		              |
|5) Back                                  |
|6) Exit                                  |
-------------------------------------------
What?:
"
	read choice
	case $choice in
		1) clear_terminal ; show_charging_limit ; battery_charge_limit_menu ;;
		2) clear_terminal ; change_charging_limit_default ; battery_charge_limit_menu ;;
		3) clear_terminal ; change_charging_limit_custom ; battery_charge_limit_menu ;;
        4) clear_terminal ; restore_charging_limit ; battery_charge_limit_menu ;;
		5) clear_terminal ; menu ;;
		6) exit 0 ;;
	esac
}

# ===================================

# ===<Swap menu>===

show_swaps(){
    echo "Showing Swaps....
    Awailable Swaps"
    cat /proc/swaps
}

disable_swaps(){
    echo "Disabling swaps....."
    sudo swapoff -a
    echo "Swaps Disabled"
}

enable_swaps(){
    echo "Enabling swaps....."
    sudo swapon -a
    echo "Swaps Enabled"
}
show_swappiness_value(){
    echo "Showing swappiness value...
    The value is:"
    cat /proc/sys/vm/swappiness
}
change_swappiness_value(){
    echo "Changing Swappiness Value..."
    sudo sh -c 'echo 10 > /proc/sys/vm/swappiness'
    echo "Swappiness Value has changed to: "
    cat /proc/sys/vm/swappiness
}
#===<End Of Swapp Menu>===#
swapp_menu(){
    echo "
------------------------------
|1) Show Swaps               |
|2) Disable Swaps            |
|3) Enable Swaps             |
|4) Show Swappiness Value    |
|5) Change Swappiness        |
|6) Back                     |
|7) Main Menu                |
|8) Exit                     |
------------------------------
What?:
"
    read a
    case $a in
        1) clear_terminal ; show_swaps ; swapp_menu ;;
        2) clear_terminal ; disable_swaps ; swapp_menu ;;
        3) clear_terminal ; enable_swaps ; swapp_menu ;;
        4) clear_terminal ; show_swappiness_value ; swapp_menu ;;
        5) clear_terminal ; change_swappiness_value ; swapp_menu ;;
        6) clear_terminal ; system_menu ;;
        7) clear_terminal ; menu ;;
        8) exit 0 ;;
    esac
}


# =================


# ===<System menu>=====

system_menu(){
    echo "
-------------------------------------------
|1) Swap Menu                             |
|2) Installer Menu                        |
|3) System Maintanance                    |
|4) Back                                  |
|5) Exit                                  |
-------------------------------------------
What?:
"
    read a
    case $a in
        1) clear_terminal ; swapp_menu ;;
        2) clear_terminal ; install_menu ;;
        3) clear_terminal ; system_maintanance_menu ;;
        4) clear_terminal ; menu ;;
        5) exit 0 ;;
    esac
}

# =====================


# ===<The main menu>===




menu(){
    echo "
--------------------------------------
| TIP:try not to use AUR that much   |
| and if you use it use -bin, -git   |
| or source code for better suport   |
| and don't use yay a lot.	         |
| Update the system every 2 days     |
| not more not less than 2 days or   |
| it will break. 		             |
--------------------------------------
|1) System menu                      |
|2) Night light                      |
|3) Charging limit                   |
|4) Winetricks                       |
|5) Linux Rice                       |
|6) Exit                             |
--------------------------------------
What?:
"
     read a
     case $a in
         1) clear_terminal ; system_menu ;;
         2) clear_terminal ; night_light_menu ;;
		 3) clear_terminal ; battery_charge_limit_menu ;;
         4) clear_terminal ; winetricks ; menu ;;
         5) clear_terminal ; linux_rice_menu ;;
         6) exit 0 ;;
     esac
}
menu
# =====================

