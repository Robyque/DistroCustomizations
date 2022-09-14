
#===<default kde categories>===
#Development
#Education
#Games
#Graphics
#Internet
#Multimedia
#System
#===<Gaming>===


pacman_gaming=(
    'discord'
    'discord-canary'
    'gamemode'
    'lutris'
    'steam'
    'steam-runtime'
    'dolphin-emu'
)


yay_gaming=(
    'playonlinux'
 'protontricks-git'!
    'protonup-qt'
 'heroic-games-launcher-bin'
)

flatpak_gaming_and_emulation=(
    'org.libretro.RetroArch'  #RetroArch
 'org.polymc.PolyMC' #PolyMC
 'org.yuzu_emu.yuzu' #yuzu
 'com.usebottles.bottles' #Bottles
 'net.pcsx2.PCSX2' #PCSX2 ps2 emulator
 'net.rpcs3.RPCS3' #RPCS3 ps3 emulator
)

#===<Programing>===

pacman_programing=(
    'kate'
    'android-tools'
    'atom'
    'codeblocks'
    'github-desktop'
    'vim'
    'mysql-workbench'
)

yay_programing=(
    'mycli-git'
)

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

#===<Content Creation>===

pacman_content_creation=(
    'blender'
    'darktable'
 'gimp'
 'inkscape'
 'obs-studio'
)

flatpak_content_creation=(
    'com.github.libresprite.LibreSprite' #LibreSprite
 'com.obsproject.Studio' #OBS Studio
 'net.blockbench.Blockbench' #Blockbench
)

#===<Others>===

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

pacman_virtualization=(
    'docker'
    #virtual box
    'virtualbox'
    'virtualbox-host-dkms'
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

flatpak_others=(
    'com.github.alainm23.planner' #Planner
 'com.github.tchx84.Flatseal' #Flatseal
 'com.spotify.Client' #Spotify
 'net.sf.VICE' #VICE
 'org.filezillaproject.Filezilla' #FileZilla
 're.sonny.Tangram' #Tangram
 'md.obsidian.Obsidian' #productivity app and notes

)


#packages that needs multi step install

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

paru_setup(){
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
}

virt_manager_qemu_setup(){
    depedencties=(
        'virt-manager'
        'qemu'
        'archlinux-keyring'_installed_package_managers
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


clear_terminal(){
    printf "\033c"
    #clear && echo -en "\e[3J" #if you are using Konsole terminal use this
}

exit_message(){
    echo "Closing the script"

    sleep 1
    clear_terminal

    exit 0
}

pacman_install(){
    package=$1
    echo "installing $package"
    sudo pacman -S "$package"
}

pacman_install_list(){
    arr=("$@")
    for i in "${arr[@]}";do
        echo "installing $i"
		sudo pacman -S "$i"
	done

}

pacman_remove(){
    package=$1
    echo "removing $package"
    sudo pacman -Rnsd "$package"
}

pacman_remove_list(){
    arr=("$@")
    for i in "${arr[@]}";do
    echo "removing $i"
		sudo pacman -Rnsd "$i"
	done
}

flatpak_install(){
    package=$1
    echo "installing $package"
    flatpak install "$package"
}

flatpak_install_list(){
    arr=("$@")
    for i in "${arr[@]}";do
    echo "installing $i"
		flatpak install "$i"
	done
}
flatpak_remove(){
    package=$1
    echo "removing $package"
    flatpak remove "$package"
}

flatpak_remove_list(){
    arr=("$@")
    for i in "${arr[@]}";do
        echo "removing $package"
		flatpak remove "$i"
	done
}

yay_install(){
    package=$1
    echo "installing $package"
    yay -S "$package"
}

yay_install_lists(){
    arr=("$@")
    for i in "${arr[@]}";do
    echo "installing $i"
		yay -S "$i"
	done
}

yay_remove(){
    package=$1
    echo "removing $package"
    yay -Rnsd "$package"
}

yay_remove_list(){
    arr=("$@")
    for i in "${arr[@]}";do
        echo "removing $package"
		yay -Rnsd "$i"
	done
}

snap_install(){
    package=$1
    echo "installing $package"
    snap install "$package"
}

snap_install_list(){
    arr=("$@")
    for i in "${arr[@]}";do
        echo "installing $i"
		snap install "$i"
	done
}

snap_remove(){
    package=$1
    echo "removing $package"
    snap uninstall "$package"
}

snap_remove_list(){
    arr=("$@")
    for i in "${arr[@]}";do "installing $package"
        echo "removing $package"
		snap uninstall "$i"
	done
}

print(){
	printf "$1 \n"
}

print_list(){
	arr=("$@")
	for i in "${arr[@]}";do
		printf "$i"
	done
}

generate_menu(){
	#don't put spaces in nameing options because this thing it's junk and it will not work=/
	option=("$@")
	row=1
	max=0
	side_border="|"
	spacer2="        "

	for v in "${option[@]}"; do
			length=${#v}
	    if (( $length > $max )); then max=$length; fi;
	done

	((max *= 2 ))

	top_border=$(printf "%-${max}s")
    printf "\n"
	echo "${top_border// /-}"

	((max /= 2))

	((max -= 1))

	spacer=$(printf "%-${max}s")

	for i in ${!option[@]};do

		generated_menu_option="$side_border $row) ${option[$i]} ${spacer// / } $side_border"
		border="${top_border// /-}"

		if ((${#generated_menu_option} < ${#border}));
		then

			spaces=$(( ${#border} - ${#generated_menu_option} + 1))
			space=$(($max + $spaces -1))
			spacers=$(printf "%-${space}s")
			echo "$side_border $row) ${option[$i]} ${spacers// / } $side_border"

		elif ((${#generated_menu_option} > ${#border}));
		then
			spaces=$((${#generated_menu_option} - ${#border}))
			space=$(($max - $spaces))
			spacers=$(printf "%-${space}s")
			echo "$side_border $row) ${option[$i]} ${spacers// / } $side_border"
		else

			echo "${generated_menu_option}"

		fi
		let "row++"

	done

	echo "${top_border// /-}"
	echo "->"

}

#=======
install_pacman_gameing_menu(){
    option=(
        'Discord'
        'Discord Canary'
        'Heral Gamemode'
        'Lutris'
        'Steam'
        'Steam runtime'
        'Dolphin Emulator'
        'Install all'
        'Back'
        'Main Menu'
        'Exit'
    )
    generate_menu "${option[@]}"
    read a
    case $a in
        1) clear_terminall ; pacman_install "${pacman_gaming[1]}" ; gameing_pacman_menu ;;
        2) clear_terminall ; pacman_install "${pacman_gaming[2]}" ; gameing_pacman_menu ;;
        3) clear_terminall ; pacman_install "${pacman_gaming[3]}" ; gameing_pacman_menu ;;
        4) clear_terminall ; pacman_install "${pacman_gaming[4]}" ; gameing_pacman_menu ;;
        5) clear_terminall ; pacman_install "${pacman_gaming[5]}" ; gameing_pacman_menu ;;
        6) clear_terminall ; pacman_install "${pacman_gaming[6]}" ; gameing_pacman_menu ;;
        7) clear_terminall ; pacman_install "${pacman_gaming[7]}" ; gameing_pacman_menu ;;
        8) clear_terminall ; pacman_install_list "${pacman_gaming[@]}" ;;
        9) clear_terminall ; gameing_install_menu ;;
        10) clear_terminal ; menu ;;
        11) exit_message;;
        *) clear_terminal ; print 'Invalid option' ; install_pacman_gameing_menu ;;
    esac

}

install_flatpak_gameing_menu(){
    option=(
        'Retroarch'
        'PolyMc'
        'Yuzu'
        'Bottles'
        'PCSX2'
        'RPCS3'
        'Install all'
        'Back'
        'Main Menu'
        'Exit'
    )
    generate_menu "${option[@]}"
    read a
    case $a in
        1) clear_terminal ; flatpak_install "${flatpak_gaming_and_emulation[1]}" ; gameing_flatpak_menu;;
        2) clear_terminal ; flatpak_install "${flatpak_gaming_and_emulation[2]}" ; gameing_flatpak_menu;;
        3) clear_terminal ; flatpak_install "${flatpak_gaming_and_emulation[3]}" ; gameing_flatpak_menu;;
        4)clear_terminal ; flatpak_install "${flatpak_gaming_and_emulation[4]}" ; gameing_flatpak_menu;;
        5)clear_terminal ; flatpak_install "${flatpak_gaming_and_emulation[5]}" ; gameing_flatpak_menu;;
        6)clear_terminal ; flatpak_install "${flatpak_gaming_and_emulation[6]}" ; gameing_flatpak_menu;;
        7) clear_terminal ; flatpak_install_list "${flatpak_gaming_and_emulation[@]}" ; gameing_flatpak_menu;;
        8) clear_terminal ;;
        9) clear_terminal ; gameing_install_menu;;
        10) clear_terminal ; menu;;
        *) clear_terminal ; print 'Invalid option' ; gameing_flatpak_menu ;;
    esac
}
install_yay_gameing_menu(){
    option=(
        'Playonlinux'
        'Protontricks'
        'Protonup'
        'Heroic games launcher'
        'Install all'
        'Back'
        'Main Menu'
        'Exit'
    )
    generate_menu "${option[@]}"
    read a
    case $a in
        1) clear_terminal ; yay_install "${yay_gaming[1]}" ; gameing_yay_menu ;;
        2) clear_terminal ; yay_install "${yay_gaming[2]}" ; gameing_yay_menu ;;
        3) clear_terminal ; yay_install "${yay_gaming[3]}" ; gameing_yay_menu ;;
        4) clear_terminal ; yay_install "${yay_gaming[4]}" ; gameing_yay_menu ;;
        5) clear_terminal ; yay_install_lists "${yay_gaming[@]}" ; gameing_yay_menu ;;
        6) clear_terminal ; gameing_install_menu ;;
        7) clear_terminal ; menu ;;
        8)  exit_message;;
        *) clear_terminal ; print 'Invalid option' ; gameing_yay_menu ;;
    esac

}
gameing_install_menu(){
    option=(
        'Pacman'
        'Flatpak'
        'Yay'
    )
    generate_menu "${option[@]}"

    read a
    case $a in
        1) clear_terminal ; install_pacman_gameing_menu ;;
        2) clear_terminal ; install_flatpak_gameing_menu ;;
        3) clear_terminal ; install_yay_gameing_menu ;;
        *) clear_terminal ; print 'Invalid option' ; gameing_install_menu ;;
    esac
}
#====
pacman_games_uninstall_menu(){
  option=(
      'Discord'
      'Discord Canary'
      'Heral Gamemode'
      'Lutris'
      'Steam'
      'Steam runtime'
      'Dolphin Emulator'
      'Install all'
      'Back'
      'Main Menu'
      'Exit'
  )
  generate_menu "${option[@]}"
  read a
  case $a in
      1) clear_terminall ; pacman_remove "${pacman_gaming[1]}" ; pacman_games_uninstall_menu ;;
      2) clear_terminall ; pacman_remove "${pacman_gaming[2]}" ; pacman_games_uninstall_menu ;;
      3) clear_terminall ; pacman_remove "${pacman_gaming[3]}" ; pacman_games_uninstall_menu ;;
      4) clear_terminall ; pacman_remove "${pacman_gaming[4]}" ; pacman_games_uninstall_menu ;;
      5) clear_terminall ; pacman_remove "${pacman_gaming[5]}" ; pacman_games_uninstall_menu ;;
      6) clear_terminall ; pacman_remove "${pacman_gaming[6]}" ; pacman_games_uninstall_menu ;;
      7) clear_terminall ; pacman_remove "${pacman_gaming[7]}" ; pacman_games_uninstall_menu ;;
      8) clear_terminall ; pacman_remove_list "${pacman_gaming[@]}" ;;
      9) clear_terminall ; gameing_uninstall_menu ;;
      10) clear_terminal ; menu ;;
      11) exit_message;;
      *) clear_terminal ; print 'Invalid option' ; pacman_games_uninstall_menu ;;
  esac
}

flatpak_games_uninstall_menu(){
  option=(
      'Retroarch'
      'PolyMc'
      'Yuzu'
      'Bottles'
      'PCSX2'
      'RPCS3'
      'Install all'
      'Back'
      'Main Menu'
      'Exit'
  )
  generate_menu "${option[@]}"
  read a
  case $a in
      1) clear_terminal ; flatpak_remove "${flatpak_gaming_and_emulation[1]}" ; flatpak_games_uninstall_menu;;
      2) clear_terminal ; flatpak_remove "${flatpak_gaming_and_emulation[2]}" ; flatpak_games_uninstall_menu;;
      3) clear_terminal ; flatpak_remove "${flatpak_gaming_and_emulation[3]}" ; flatpak_games_uninstall_menu;;
      4)clear_terminal ; flatpak_remove "${flatpak_gaming_and_emulation[4]}" ; flatpak_games_uninstall_menu;;
      5)clear_terminal ; flatpak_remove "${flatpak_gaming_and_emulation[5]}" ; flatpak_games_uninstall_menu;;
      6)clear_terminal ; flatpak_remove "${flatpak_gaming_and_emulation[6]}" ; flatpak_games_uninstall_menu;;
      7) clear_terminal ; flatpak_remove_list "${flatpak_gaming_and_emulation[@]}" ; flatpak_games_uninstall_menu;;
      8) clear_terminal ;;
      9) clear_terminal ; gameing_uninstall_menu;;
      10) clear_terminal ; menu;;
      *) clear_terminal ; print 'Invalid option' ; flatpak_games_uninstall_menu ;;
  esac

}

yay_games_uninstall_menu(){
  option=(
      'Playonlinux'
      'Protontricks'
      'Protonup'
      'Heroic games launcher'
      'Install all'
      'Back'
      'Main Menu'
      'Exit'
  )
  generate_menu "${option[@]}"
  read a
  case $a in
      1) clear_terminal ; yay_remove "${yay_gaming[1]}" ; yay_games_uninstall_menu ;;
      2) clear_terminal ; yay_remove "${yay_gaming[2]}" ; yay_games_uninstall_menu ;;
      3) clear_terminal ; yay_remove "${yay_gaming[3]}" ; yay_games_uninstall_menu ;;
      4) clear_terminal ; yay_remove "${yay_gaming[4]}" ; yay_games_uninstall_menu ;;
      5) clear_terminal ; yay_remove_lists "${yay_gaming[@]}" ; yay_games_uninstall_menu ;;
      6) clear_terminal ; gameing_uninstall_menu ;;
      7) clear_terminal ; menu ;;
      8)  exit_message;;
      *) clear_terminal ; print 'Invalid option' ; yay_games_uninstall_menu ;;
  esac

}

gameing_uninstall_menu(){
  option=(
      'Pacman'
      'Flatpak'
      'Yay'
  )
  generate_menu "${option[@]}"

  read a
  case $a in
      1) clear_terminal ; pacman_games_uninstall_menu ;;
      2) clear_terminal ; flatpak_games_uninstall_menu ;;
      3) clear_terminal ; yay_games_uninstall_menu ;;
      *) clear_terminal ; print 'Invalid option' ; gameing_uninstall_menu ;;
  esac

}

gameing_menu(){
    option=(
        'Install'
        'Uninstall'
        'Back'
        'Main Menu'
        'Exit'
    )
    generate_menu "${option[@]}"
    read a
    case $a in
        1) clear_terminal ; gameing_install_menu ;;
        2) clear_terminal ; gameing_uninstall_menu ;;
        3) clear_terminal ; install_menu ;;
        4) clear_terminal ; menu ;;
        5) exit_message ;;
        *) clear_terminal ; print 'Ivalid option' ; gameing_menu;;
    esac
}

#graphics_menu(){}

#virtualiation_menu(){}

#development_menu(){}

#system_menu(){}

#internet_menu(){}

#others_menu(){}
