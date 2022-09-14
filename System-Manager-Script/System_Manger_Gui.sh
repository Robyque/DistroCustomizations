#!/bin/bash
DIALOG_OK=0
DIALOG_CANCEL=1
DIALOG_BACK=3
DIALOG_ESC=255
HEIGHT=0
WIDTH=0

display_result() {
    title=$1
    #result
    page=$2
    exec 3>&1
    selection=$(dialog \
    --title "$title" \
    --no-collapse \
    --msgbox "$result" 0 0 2>&1 1>&3)
    exit_status=$?
    exec 3>&-
    case $exit_status in
    $DIALOG_OK)
        $page;;
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
  esac
}

read_input(){
    dialog \
    --clear \
    --title "$1" \
    --no-collapse \
    --inputbox "$text" 0 0
}

#---<ARCH BASED DISTRIBUTION>---#
#---<System Maintanance Menu>---#
update_pacman(){
    echo "Running system update...."
    sudo pacman -Syyu
}
update_yay(){
    yay
}
update_flatpak(){
    sudo flatpak update
}
check_systemd(){
    systemctl --failed

}
log_files_check(){
    sudo journalctl -p 3 -xb
}
delete_pacman_cache(){
    sudo pacman -Scc
}
delete_yay_cache(){
    yay -Scc
}
delete_unwanted_dependencies(){
    yay -Yc
}
remove_orphan_packages(){
    sudo aura -Oj
}
clean_cache(){
    sudo rm -rf .cache/*
}
clean_journal(){
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
#---<Night Light Menu>---#

#--------------------------#
custom_temperature(){
    echo "Enter value:"
    read c
    echo "Enabling night light with value: ${c}k"
    redshift -O "${c}"
}
default_temperature(){
    redshift -O 3000
}

disable_night_light(){
    redshift -x
}
#---<Install Menu>---#
minimal(){
    #Installing package managers (yay,flatpak,snap)
    echo "Installing flatpak package manager...."
    sudo pacman -S flatpak
    echo "Installing yay AUR package manager...."
    sudo pacman -S git
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    echo "Installing snap package manager...."
    yay snapd

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
    #yay(AUR)
    }
normal(){
    #Installing package managers (yay,flatpak,snap)
    echo "Installing flatpak package manager...."
    sudo pacman -S flatpak
    echo "Installing yay AUR package manager...."
    sudo pacman -S git
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    echo "Installing snap package manager...."
    yay snapd
    #pacman
    PPKGS=(
        'firefox' #browser default
        'alacritty' #default terminal
        'dolphin' #default file manager
        #'thunar' #file manager
        'engrampa' #archive manager
        'vlc' #video player
        'nomacs' #image viewer
        'feh' #image viewer
        'audacious' #audio player
        'neofetch'
        'htop' #terminal task manager
        'xrandr' #screen resolution manager
        'nitrogen' #teminal background manager
        'picom' #compositor
        'xorg-xinput' #xorg input manager
        'popsicle' #usb flasher for linux(curently windows iso not suported)
        'cmatrix'
        'libreoffice'
        'calibre'
        'flameshot'
        'onboard'
        'qbittorrent'
        'aura-bin'
        'redshift'
        'minder' #efficiency app
        'lightdm' #login manager
        'lightdm-gtk-greeter'

    )
    for PPKG in "${PPKGS[@]}"; do
        echo "Installing: ${PPKG} via pacman"
        sudo pacman -S "$PPKG" --noconfirm --needed
    done
    #enabling services
    sudo systemctl enable lightdm.service
    #flatpak
    FPKGS=(
        're.sonny.Tangram' #tangram
        'com.spotify.Client' #spotify
        'us.zoom.Zoom' #zoom client
        'com.skype.Client' #skype
        'com.github.alainm23.planner' #efficiency app

    )
    for FPKG in "${FPKGS[@]}"; do
        echo "Installing: ${FPKG} via flatpak"
        sudo flatpak install "$FPKG"
    done
}
gameing(){
    #pacman app list
    PPKGS=(
        'discord'
        'discord-canary'
        'steam-native'
        'lutris'
        'winetricks'
    )
     for PPKG in "${PPKGS[@]}"; do
        echo "Installing: ${PPKG} via pacman"
        sudo pacman -S "$PPKG" --noconfirm --needed
     done


    #flatpak app list
    FPKGS=(
      'io.mrarm.mcpelauncher' #minecraft bedrock launcher for linux
      'com.github.Matoking.protontricks' #like winetricks but for proton
      #'com.valvesoftware.Steam' #steam game launcher
    )
     for FPKG in "${FPKGS[@]}"; do
        echo "Installing: ${FPKG} via flatpak"
        sudo flatpak install "$FPKG"
     done
    #aur app
     APKGS=(
         'protonup-git' #proton and wine manager for steam and lutris
     )
     for APKG in "${APKGS[@]}"; do
       echo "Insalling: ${APKG} via yay"
       yay "${APKG}"
     done
}
art(){
    PKGS=(
        'krita'
        'inkscape'
        'obs-studio'
        'blender'
        'kdenlive'
        'darktable'
        'gimp'
    )
     for PKG in "${PKGS[@]}"; do
        echo "Installing: ${PKG} via pacman"
        sudo pacman -S "$PKG" --noconfirm --needed
     done
     FPKGS=(
         'com.github.libresprite.LibreSprite' #LibreSprite pixel art editor
         'net.blockbench.Blockbench' #Minecraft 3d model maker
     )
     for SPKG in "${FPKGS[@]}"; do
       echo "Installing: ${SPKG} via flatpak"
       flatpak install "${SPKG}"
     done


}
efficiency(){
    echo "installing Minder...."
    sudo pacman -S minder
    echo "Installing Planner...."
    flatpak install com.github.alainm23.planner
}
virtualization(){
    PKGS=(
        #virtul box
        'virtualbox'
        #virt manager & depedencies
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
        'docker'
    )
     for PKG in "${PKGS[@]}"; do
        echo "Installing: ${PKG} via pacman"
        sudo pacman -S "$PKG" --noconfirm --needed
     done

    #Warning user to sudo chmod +x for using external hard drives
    echo "To user external hard drives use 'sudo chmod +x /run/media/user/drive'
    and don't use spaces in folder names because virt manager can't read spaces."
    #Starting kvm libvirt service
    sudo systemctl enable libvirtd.service
    sudo systemctl start libvirtd.service
    #Showing kvm service status
    systemctl status libvirtd.service
    #Adding user to libvirt group
    sudo usermod -a -G libvirt $(whoami)
    #Restarting kvm service
    sudo systemctl restart libvirtd.service
}
programing(){
    #pacman apps
    PPKGS=(
        'cmake'
        'atom'
        'kate'
        'emacs'
        'codeblocks'
        'jdk11-openjdk'
        'pycharm-community-edition'
        'gvim'
        'qtcreator'

    )
     for PPKG in "${PPKGS[@]}"; do
        echo "Installing: ${PPKG} via pacman"
        sudo pacman -S "$PPKG" --noconfirm --needed
    done

    #Snap apps
    SPKGS=(
        'sublime-text' #sublime text editor
        'eclipse' #eclipse ide for java
        'code' #visual studio code
        'code-insiders' #visual studio code insiders
    )
     for SPKG in "${SPKGS[@]}"; do
        echo "Installing: ${SPKG} via snap"
        sudo snap install "$SPKG "--classic
    done

}
terminals(){
    PKGS=(
        'kitty'
        'konsole'
        'yakuake'
        'cool-retro-term'
    )
     for PKG in "${PKGS[@]}"; do
        echo "Installing: ${PKG} via pacman"
        sudo pacman -S "$PKG" --noconfirm --needed
    done

}
browsers(){
    PPKGS=(
        'firefox'
        'opera'
        'vivaldi-stable'
        'chromium'
        'qutebrowser'
        'vimb'
    )
     for PPKG in "${PPKGS[@]}"; do
        echo "Installing: ${PPKG} via pacman"
        sudo pacman -S "$PPKG" --noconfirm --needed
    done
     FPKGS=(
         're.sonny.Tangram'
     )
     for FPKG in "${FPKGS[@]}"; do
       echo "Installing: ${FPKG} via flatpak"
       flatpak install "${FPKG}"
     done

}
unixporn(){
    echo "Some of the apps need manual install for the moment."
    #pacman
    PPKGS=(
        'conky-manager'
    )
     for PPKG in "${PPKGS[@]}"; do
        echo "Installing: ${PPKG} via pacman"
        sudo pacman -S "$PPKG" --noconfirm --needed
     done
    #uning yay and aur
    echo "ATENTION!! USING YAY AND AUR"
    #yay(AUR)
    YPKGS=(
        'cava' #terminal sound react
        'tty-clock' #terminal clock
        'pipes' #terminal pipes
        'pfetch' #neofetch but small
        'pixterm' #image to pixelart converter
        'cbonsai-git' #terminal bonsai
        'bpytop' #htop clone but prettier
    )
    #all the tools for making linux rice
    #like cava ttk-clock pipes pfetch feh
    for YPKG in "${YPKGS[@]}"; do
      echo "Installing: ${YPKG} via yay"
      yay "${YPKG}"
    done

}
package_managers(){
    echo "Installing Package managers...."
     #Installing package managers (yay,flatpak,snap)
    echo "Installing flatpak package manager...."
    sudo pacman -S flatpak
    echo "Installing yay AUR package manager...."
    sudo pacman -S git
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    echo "Installing snap package manager...."
    yay snapd
}
#---<Desktop Enviroment & Window managers menu>---#

#<Official suported>
budgie(){
    echo "Installing Budgie desktop enviroment...."
    sudo pacman -S budgie-desktop
}
cinnamon(){
    echo "Installing Cinnamon desktop enviroment...."
    sudo pacman -S cinnamon
}
cutefish(){
    echo "Installing Cutefish desktop enviroment...."
    sudo pacman -S cutefish
}
deepin(){
    echo "Installing Deepin desktop enviroment...."
    sudo pacman -S deepin
}
enlightenment(){
    echo "Installing Enlightenment desktop enviroment...."
    sudo pacman -S enlightenment
}
gnome(){
    echo "Installing Gnome desktop enviroment..."
    sudo pacman -S gnome
}
gnome_flashback(){
    echo "Installing Gnome Flashback desktop enviroment...."
    sudo pacman -S gnome-flashback
}
kde(){
    echo "Installing KDE Plasma desktop enviroment...."
    sudo pacman -S plasma
}
lxde(){
    echo "Installing LXDE desktop enviroment...."
    sudo pacman -S lxde-gtk3
}
lxqt(){
    echo "Installing LXQT desktop enviroment...."
    sudo pacman -S lxqt
}
mate(){
    echo "Installing MATE desktop enviroment...."
    sudo pacman -S mate
}
sugar(){
    echo "Installing Sugar desktop enviroment...."
    sudo pacman -S sugar sugar-fructose
}
ukui(){
    echo "Installing UKUI desktop enviroment...."
    sudo pacman -S ukui
}
xfce(){
    echo "Installing XFCE desktop enviroment...."
    sudo pacman -S xfce4
}
#<Unofficially supported>
cde(){
    echo "Installing CDE desktop enviroment...."
    yay cdesktopenv
}
ede(){
    echo "Installing EDE desktop enviroment...."
    yay ede
}
kde_1(){
    echo "installing KDE 1 desktop enviroment...."
    yay kde1-kdebase-git
}
liri(){
    echo "Installing Liri desktop enviroment...."
    yay liri-shell-git

}
lumina(){
    echo "Installing Lumina desktop enviroment...."
    yay lumina-desktop
}
moksha(){
    echo "Installing Moksha desktop enviroment...."
    yay moksha-git
}
pantheon(){
    echo "Installing Pantheon desktop enviroment...."
    yay pantheon-session-git
}
paperde(){
    echo "Installing PaperDE desktop enviroment...."
    yay paperde
}
phosh(){
    echo "Installing Phosh desktop enviroment...."
    yay phosh-git
}
thedesk(){
    echo "Installing TheDeskt desktop enviroment...."
    yay thedesk
}
trinity(){
    echo "Installing Trinity desktop enviroment...."
    yay trinity
}
#<Other window managers>
i3wm(){
    echo "Installing i3 & Polybar window manager...."
    sudo pacman -S i3-gaps polybar
}
qtile(){
    echo "Installing Qtile window manager...."
    sudo pacman -S qtile
}
awesome(){
    echo "Installing Awesome window manager...."
    sudo pacman -S awesome
}
xmonad(){
    echo "Installing xmonad window manager...."
    sudo pacman -S xmonad xmonad-contrib xmonad-utils
}
openbox(){
    echo "Installing openbox window manager...."
    sudo pacman -S openbox ttf-dejavu ttf-liberation
}
#---<Swapp Menu>---#

show_swaps(){
    
    result=$(cat /proc/swaps)
    display_result "Available Swaps" swapp_menu
}

disable_swaps(){
    result=$(echo "Disabled Available Swapps"; sudo swapoff -a)
    display_result "Swapp Manager" swapp_menu
}

enable_swaps(){
    result=$(echo "Enabled Available Swapps"; sudo swapon -a)
    display_result "Swapp Manager" swapp_menu
}
show_swappiness_value(){
    result=$(echo "The value is:"; cat /proc/sys/vm/swappiness)
    display_result "Swapp Current Value" swapp_menu
}
change_swappiness_value(){
    sudo sh -c 'echo 10 > /proc/sys/vm/swappiness'
    result=$(echo "The value is:"; cat /proc/sys/vm/swappiness)
    display_result "Swapp Changed Value" swapp_menu
}

#---<Menus>---#
main_menu(){
    exec 3>&1
    selection=$(dialog \
    --title "Base System" \
    --clear \
    --cancel-label "Exit" \
    --menu "Please Select:" $HEIGHT $WIDTH 10 \
    "1" "Arch Based" \
    "2" "Debian Based" \
    2>&1 1>&3)
    exit_status=$?
    exec 3>&-
    case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
  esac
    #---
    case $selection in
    1) arch_based_menu;;
    esac
}
#Arch Based Distributio
arch_based_menu(){
    exec 3>&1
    arch=$(dialog \
    --title "Arch Based System" \
    --clear \
    --cancel-label "Exit" \
    --extra-button \
    --extra-label "Back" \
    --menu "Please Select:" $HEIGHT $WIDTH 10 \
    "1" "Swap Menu" \
    "2" "Install Menu" \
    "3" "System Maintanance" \
    "4" "Night Light Menu" \
    2>&1 1>&3)
    exit_status=$?
    exec 3>&-
    case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
    $DIALOG_BACK)
    	main_menu;;	
  esac
    #---
    case $arch in
   	1) swapp_menu ;;
   	2) install_menu ;;
    3) system_maintanance_menu ;;
    4) night_light_menu ;;
    esac
}
#---<Swap Menu>---#

swapp_menu(){
	exec 3>&1
    swapp=$(dialog \
    --title "Swapp Partition Management" \
    --clear \
    --cancel-label "Exit" \
    --extra-button \
    --extra-label "Back" \
    --menu "Please Select:" $HEIGHT $WIDTH 10 \
    "1" "Show Swapps" \
    "2" "Disable Swapps" \
    "3" "Enable Swapps" \
    "4" "Show Swappiness Value" \
    "5" "Change Swappiness" \
    2>&1 1>&3)
    exit_status=$?
    echo $exit_status
    exec 3>&-
    case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
    $DIALOG_BACK)
    	main_menu;;	  
    esac
    case $swapp in
    	1) show_swaps ;;
        2) disable_swaps ;;
        3) enable_swaps ;;
        4) show_swappiness_value ;;
        5) change_swappiness_value ;;
    esac 

}

#---<Desktop Enviroment & Window managers menu>---#

ofsde_menu(){
	exec 3>&1
    ofsde=$(dialog \
    --title "Official Supported Desktop Enviroments" \
    --clear \
    --extra-button \
    --extra-label "Back" \
    --cancel-label "Exit" \
    --menu "Please Select:" $HEIGHT $WIDTH 10 \
    "1" "Budgie" \
	"2" "Cinnamon" \
	"3" "Cutefish" \
	"4" "Deepin" \
	"5" "Enlightenment" \
	"6" "Gnome" \
	"7" "Gnome Flashback" \
	"8" "KDE" \
	"9" "LXDE" \
	"10" "MATE" \
	"11" "Sugar" \
	"12" "Ukui" \
	"13" "XFCE" \
    2>&1 1>&3)
    exit_status=$?
    exec 3>&-
    case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
    $DIALOG_BACK)
    	de_wm_menu;;	  
    esac
    case $ofsde in
    	1) budgie ; ofsde_menu ;;
     	2) cinnamon ; ofsde_menu ;;
     	3) cutefish ; ofsde_menu ;;
     	4) deepin ; ofsde_menu ;;
     	5) enlightenment ; ofsde_menu ;;
     	6) gnome ; ofsde_menu ;;
     	7) gnome_flashback ; ofsde_menu ;;
     	8) kde ; ofsde_menu ;;
     	9) lxde ; ofsde_menu ;;
     	10) mate ; ofsde_menu ;;
     	11) sugar ; ofsde_menu ;;
     	12) ukui ; ofsde_menu ;;
     	13) xfce ; ofsde_menu ;;
    esac
}

usde_menu(){
	exec 3>&1
    usde=$(dialog \
    --title "Unofficial Supported Desktop Enviroments" \
    --clear \
    --extra-button \
    --extra-label "Back" \
    --cancel-label "Exit" \
    --menu "Please Select:" $HEIGHT $WIDTH 10 \
    "1" "CDE" \
    "2" "EDE" \
    "3" "KDE 1" \
    "4" "Liri" \
    "5" "Lumina" \
    "6" "Moksha" \
    "7" "Phanteon" \
    "8" "PaperDE" \
    "9" "Phosh" \
    "10" "TheDesk" \
    "11" "Trinity" \
    2>&1 1>&3)
    exit_status=$?
    exec 3>&-
    case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
    $DIALOG_BACK)
    	de_wm_menu;;	  
    esac
    case $usde in
    	1) cde ; usde_menu ;;
        2) ede ; usde_menu ;;
        3) kde_1 ; usde_menu ;;
        4) liri ; usde_menu ;;
        5) lumina ; usde_menu ;;
        6) moksha ; usde_menu ;;
        7) pantheon ; usde_menu ;;
        8) paperde ; usde_menu ;;
        9) phosh ; usde_menu ;;
        10) thedesk ; usde_menu ;;
        11) trinity ; usde_menu ;;
    esac
}

owm_menu(){
	exec 3>&1
    owm=$(dialog \
    --title "Others Window Managers" \
    --clear \
    --extra-button \
    --extra-label "Back" \
    --cancel-label "Exit" \
    --menu "Please Select:" $HEIGHT $WIDTH 10 \
    "1" "i3" \
    "2" "Qtile" \
    "3" "Awesome" \
    "4" "Xmonad" \
    "5" "Openbox" \
    2>&1 1>&3)
    exit_status=$?
    exec 3>&-
    case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
    $DIALOG_BACK)
    	de_wm_menu;;	  
    esac

    case $owm in
    	1) i3wm ; owm_menu ;;
        2) qtile ; owm_menu ;;
        3) awesome ; owm_menu ;;
        4) xmonad ; owm_menu ;;
        5) openbox ; owm_menu ;;
    esac
}

de_wm_menu(){
	exec 3>&1
    dewm=$(dialog \
    --title "Window Managers And Desktop Enviroments" \
    --clear \
    --extra-button \
    --extra-label "Back" \
    --cancel-label "Exit" \
    --menu "Please Select:" $HEIGHT $WIDTH 10 \
    "1" "Official supported desktop enviroment" \
    "2" "Unofficial supported desktop enviroment" \
    "3" "Tiling window managers" \
    2>&1 1>&3)
    exit_status=$?
    exec 3>&-
    case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
    $DIALOG_BACK)
    	install_menu;;	  
    esac
    case $dewm in
    	1)ofsde_menu ;;
        2)usde_menu ;;
        3)owm_menu ;;
    esac
}
#---
install_menu(){
    exec 3>&1
    installMenu=$(dialog \
    --title "Arch Based System" \
    --clear \
    --extra-button \
    --extra-label "Back" \
    --cancel-label "Exit" \
    --menu "Please Select:" $HEIGHT $WIDTH 10 \
    "1" "Desktop Enviroment & Window managers menu" \
    "2" "Minimal instalation" \
    "3" "Normal instalation" \
    "4" "Package managers(yay,flatpak,snap)" \
    "5" "Gaming apps" \
    "6" "Art apps" \
    "7" "Virtualization Apps" \
    "8" "Programing Apps" \
    "9" "Terminals" \
    "10" "Browsers" \
    "11" "Linux Rice" \
    "12" "Productivity" \
    2>&1 1>&3)
    exit_status=$?
    exec 3>&-
    case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
    $DIALOG_BACK)
    	arch_based_menu;;	
  esac
    #---
    case $installMenu in
        1) de_wm_menu ; install_menu ;;
        2) minimal ; install_menu ;;
        3) normal ; install_menu ;;
        4) package_managers ; install_menu ;;
        5) gameing ; install_menu ;;
        6) art ; install_menu ;;
        7) virtualization ; install_menu ;;
        8) programing ; install_menu ;;
        9) terminals ; install_menu ;;
        10) browsers ; install_menu ;;
        11) unixporn ; install_menu ;;
        12) efficiency ; install_menu ;;
    esac
}
#---
system_maintanance_menu(){
    exec 3>&1
    system_maintanance=$(dialog \
    --title "System Maintanance" \
    --clear \
    --extra-button \
    --extra-label "Back" \
    --cancel-label "Exit" \
    --menu "Please Select" $HEIGHT $WIDTH 10 \
    "1" "Update pacman" \
    "2" "Update yay" \
    "3" "Update flatpak" \
    "4" "Check systemd" \
    "5" "System log" \
    "6" "Delete pacman cache" \
    "7" "Delete yay cache" \
    "8" "Delete unwanted dependencies" \
    "9" "Remove Orphan Packageews" \
    "10" "Clean cache" \
    "11" "Clean journal" \
    "12" "Disable internal keyboard" \
    "13" "Enable internal keyboard" \
    2>&1 1>&3)
    exit_status=$?
    exec 3>&-
    case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
    $DIALOG_BACK)
    	arch_based_menu;;	  
  esac
    #---
    case $system_maintanance in
    1) update_pacman ; system_maintanance_menu ;;
    2) update_yay ; system_maintanance_menu ;;
    3) update_flatpak ;;
    4) 	result=$(check_systemd)
		display_result Systemd-Log system_maintanance_menu;;
    5) log_files_check ; system_maintanance_menu ;;
    6) delete_pacman_cache ; system_maintanance_menu ;;
    7) delete_yay_cache ; system_maintanance_menu ;;
    8) delete_unwanted_dependencies ; system_maintanance_menu ;;
    9) remove_orphan_packages ; system_maintanance_menu ;;
    10) clean_cache ; system_maintanance_menu ;;
    11) clean_journal ; system_maintanance_menu ;;
    12) disable_internal_keyboard ; system_maintanance_menu ;;
    13) enable_internal_keyboard ; system_maintanance_menu ;;
  esac
}
#---
enable_night_light_menu(){
    exec 3>&1
    selection=$(dialog \
    --title "Night Light Menu" \
    --clear \
    --extra-button \
    --extra-label "Back" \
    --cancel-label "Exit" \
    --menu "Please Select:" $HEIGHT $WIDTH 10 \
    "1" "Default" \
    "2" "Custom" \
    2>&1 1>&3)
    exit_status=$?
    exec 3>&-
    case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
    $DIALOG_BACK)
    	arch_based_menu;;	  
  esac
  case $selection in
    1) default_temperature;;
    2) custom_temperature;;
  esac
}
night_light_menu(){
    exec 3>&1
    selection=$(dialog \
    --title "Night Light Menu" \
    --clear \
    --extra-button \
    --extra-label "Back" \
    --cancel-label "Exit" \
    --menu "Please Select:" $HEIGHT $WIDTH 10 \
    "1" "Enable Night Light" \
    "2" "Disable Night Light" \
    2>&1 1>&3)
    exit_status=$?
    exec 3>&-
    case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
    $DIALOG_BACK)
    	arch_based_menu;;	  
  esac
  case $selection in
    1) enable_night_light_menu ;;
    2) disable_night_light ;;
  esac
}
#============================================
main_menu
