#!/usr/bin/env bash

show_msg () {
    echo -e '\e[32m'$1'\e[0m'
}

install_update(){
		sudo pkcon -y refresh && sudo pkcon -y update 
		sudo apt -y update && sudo apt -y upgrade
		sudo apt install -y net-tools htop
}

install_flatpak(){
		sudo apt -y install flatpak
		sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
		sudo apt -y install gnome-software-plugin-flatpak
}

install_wine(){
		sudo dpkg --add-architecture i386 
		curl -s https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add - 
		sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
		sudo add-apt-repository -y ppa:cybermax-dexter/sdl2-backport
		sudo apt -y update && sudo apt -y install --install-recommends winehq-stable
		wine64 uninstaller 
}

install_terminator(){
		sudo apt -y install terminator
		mkdir -p $HOME/.config/terminator/plugins 
#		wget https://git.io/v5Zww -O $HOME"/.config/terminator/plugins/terminator-themes.py"
#		cp $(pwd)/config/config ~/.config/terminator/
}

install_brave(){
		sudo apt -y install apt-transport-https
		curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - 
		echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list 
		sudo apt -y update && sudo apt -y install brave-browser
}

install_conky(){
		sudo apt -y install conky conky-all
		mkdir -p ~/.conky
		sudo tar -xvzf $(pwd)/config/conky.tar.gz -C ~/.conky
		chmod +x $(pwd)/config/conky-manager_2.7_amd64.deb
		sudo dpkg -i $(pwd)/config/conky-manager_2.7_amd64.deb
		sudo apt -y --fix-broken install
}

install_chrome(){
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
		sudo chmod +x chrome.deb && sudo dpkg -i chrome.deb && rm chrome.deb
}

install_teamviewer(){
		sudo apt -y install teamviewer
		sudo apt -y --fix-broken install
}

install_code(){
		curl -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -o code.deb
		sudo chmod +x code.deb && sudo dpkg -i code.deb && rm code.deb
}

install_vnc(){
		sudo chmod +x $(pwd)/config/VNC-Server-6.7.2-Linux-x64.deb && sudo dpkg -i $(pwd)/config/VNC-Server-6.7.2-Linux-x64.deb
}

install_parcellite(){
		sudo apt -y install parcellite
}

install_flameshot(){
		sudo apt -y install flameshot
}

install_ncdu(){
		sudo apt -y install ncdu
}

install_xfce_profiles(){
		sudo apt -y install xfce4-panel-profiles
}

install_vlc(){
		sudo apt -y install vlc
}

install_stacer(){
		sudo apt -y install stacer
}

install_kazam(){
		sudo apt -y install kazam
}

install_audacity(){
		sudo apt -y install audacity
}

install_clamav(){
		sudo apt -y install clamav clamtk
}

install_ffmpeg(){
		sudo apt -y install ffmpeg
}

install_remmina(){
		sudo apt-add-repository -y ppa:remmina-ppa-team/remmina-next
		sudo apt -y update
		sudo apt -y install remmina
}

install_grub_customizer(){
		sudo apt -y install grub-customizer
}

install_cifs_utils(){
		sudo apt -y install cifs-utils pst-utils
}

install_gparted(){
		sudo apt -y install gparted
}

install_bashrc() {
		if [[ $(cat ~/.bashrc | grep -o dotfiles) == dotfiles ]]; then
			echo "bashrc is already sourced"
		else
			echo 'source ~/.doty/.bashrc' >> ~/.bashrc
		fi
		source "$HOME"/.bashrc
}

install_resolvconf(){
		sudo apt -y install resolvconf
		sudo systemctl enable resolvconf.service 
		sudo systemctl start resolvconf.service 
		if [[ $(cat /etc/resolvconf/resolv.conf.d/head | grep "nameserver 8.8.8.8") == 'nameserver 8.8.8.8' ]]; then
			echo "resolvconf is updated"
		else
			curl -sk https://gist.githubusercontent.com/Sy3Omda/fdd65bbe455b4da93b66ef348b3bd15f/raw/f5250d59d68553c2a4f0b7d88d207bdb0f8bf8af/resolvers.txt | sudo tee -a /etc/resolvconf/resolv.conf.d/head 
		fi
		sleep 1
}

install_hp_printers(){
		sudo apt -y install cups hplip avahi-daemon printer-driver-gutenprint
		wget -O foo2zjs.tar.gz http://foo2zjs.rkkda.com/foo2zjs.tar.gz && tar zxf foo2zjs.tar.gz && cd foo2zjs
		sudo make install && sudo make install-hotplug
		cd - && rm -rf foo2zjs*
}

install_timeshift(){
		sudo apt -y install timeshift
}

install_peek(){
		sudo apt -y install peek
}

install_kubuntu_driver_manager(){
		# Proprietary/Nvidia Driver Installer
		sudo apt -y install kubuntu-driver-manager
}


install_qapt_deb_installer(){
		# (.deb) GUI Installer
		sudo apt -y install qapt-deb-installer
}

install_nodejs(){
		curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
		sudo apt -y install nodejs
}

install_libreoffice(){
		sudo add-apt-repository -y ppa:libreoffice/ppa
		sudo apt -y update
		sudo apt-get -y install libreoffice libreoffice-gtk3 libreoffice-style-*
		sudo apt -y install fonts-crosextra-carlito fonts-crosextra-caladea
		rm ~/.cache/icon-cache.kcache
}

install_thunderbird(){
		sudo apt -y install thunderbird
}

install_nativefier(){
		# Check if nodejs installed
		if [ $(node -v) ]
		then
			echo "nodejs is installed"
		else
			echo "installing nodejs"
			curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
			sudo apt -y install nodejs
		fi
		
		# Check if nativefier installed
		if [ $(nativefier -v) ]
		then
			echo "nativefier is installed"
		else
			echo "installing nativefier"
			sudo npm install -g nativefier
		fi
		
		# Check the path exists.
		[ -d "/opt/nativefier" ] || sudo mkdir -p "/opt/nativefier"
		cd "/opt/nativefier"
		
		# Force install followed websites for personal use.
		sudo nativefier --name 'FaceBook' 'www.facebook.com'
		sudo nativefier --name 'WhatsApp' 'web.whatsapp.com'
		sudo nativefier --name 'Telegram' 'web.telegram.org'
		sudo nativefier --name 'Gmail' 'mail.google.com'
		sudo nativefier --name 'Twitter' 'twitter.com'
		sudo nativefier --name 'Github' 'github.com'
		
		# Disable choice for now
#		read -p "Install FaceBook webapp (y/n)?" choice
#       case "$choice" in
#       y|Y ) sudo nativefier --name 'FaceBook' 'www.facebook.com';;
#       n|N ) show_msg "\nSkipped FaceBook !";;
#       esac
		
#		read -p "Install WhatsApp webapp (y/n)?" choice
#       case "$choice" in
#       y|Y ) sudo nativefier --name 'WhatsApp' 'web.whatsapp.com';;
#       n|N ) show_msg "\nSkipped WhatsApp !";;
#       esac
		
#		read -p "Install Telegram webapp (y/n)?" choice
#       case "$choice" in
#       y|Y ) sudo nativefier --name 'Telegram' 'web.telegram.org';;
#       n|N ) show_msg "\nSkipped Telegram !";;
#       esac
		
#		read -p "Install Gmail webapp (y/n)?" choice
#       case "$choice" in
#       y|Y ) sudo nativefier --name 'Gmail' 'mail.google.com';;
#       n|N ) show_msg "\nSkipped Gmail !";;
#       esac
		
#		read -p "Install Twitter webapp (y/n)?" choice
#       case "$choice" in
#       y|Y ) sudo nativefier --name 'Twitter' 'twitter.com';;
#       n|N ) show_msg "\nSkipped Twitter !";;
#       esac
		
#		read -p "Install Github webapp (y/n)?" choice
#       case "$choice" in
#       y|Y ) sudo nativefier --name 'Github' 'github.com';;
#       n|N ) show_msg "\nSkipped Github !";;
#       esac
		
		cd -
}

install_all(){
		install_update
		install_flatpak
		install_terminator
		install_bashrc
		install_brave
		install_conky
		install_chrome
		install_code
		install_parcellite
		install_flameshot
		install_ncdu
		install_vlc
		install_stacer
		install_kazam
		install_audacity
		install_clamav
		install_ffmpeg
		install_remmina
		install_grub_customizer
		install_cifs_utils
		install_gparted
		install_wine
		install_resolvconf
		install_timeshift
		install_peek
		install_kubuntu_driver_manager
		install_qapt_deb_installer
		install_nodejs
		install_libreoffice
		install_thunderbird
		install_nativefier
}

		read -p "Install All Programs. Are you sure (y/n)?" choice
		case "$choice" in 
		y|Y ) install_all;;
		n|N ) show_msg "\nInstall programs seperatly." && 
				read -p "Install update (y/n)?" choice
				case "$choice" in
				y|Y ) install_update;;
				n|N ) show_msg "\nSkipped update !";;
				esac
				
				read -p "Install flatpak (y/n)?" choice
                case "$choice" in
                y|Y ) install_flatpak;;
                n|N ) show_msg "\nSkipped flatpak !";;
                esac

				read -p "Install terminator (y/n)?" choice
				case "$choice" in
				y|Y ) install_terminator;;
				n|N ) show_msg "\nSkipped terminator !";;
				esac
				
				read -p "Install bashrc (y/n)?" choice
				case "$choice" in
				y|Y ) install_bashrc;;
				n|N ) show_msg "\nSkipped bashrc !";;
				esac

				read -p "Install brave (y/n)?" choice
				case "$choice" in
				y|Y ) install_brave;;
				n|N ) show_msg "\nSkipped brave !";;
				esac

				read -p "Install conky (y/n)?" choice
				case "$choice" in
				y|Y ) install_conky;;
				n|N ) show_msg "\nSkipped conky !";;
				esac

				read -p "Install chrome (y/n)?" choice
				case "$choice" in
				y|Y ) install_chrome;;
				n|N ) show_msg "\nSkipped chrome !";;
				esac

				read -p "Install teamviewer (y/n)?" choice
				case "$choice" in
				y|Y ) install_teamviewer;;
				n|N ) show_msg "\nSkipped teamviewer !";;
				esac

				read -p "Install code (y/n)?" choice
				case "$choice" in
				y|Y ) install_code;;
				n|N ) show_msg "\nSkipped code !";;
				esac

				read -p "Install vnc (y/n)?" choice
				case "$choice" in
				y|Y ) install_vnc;;
				n|N ) show_msg "\nSkipped vnc !";;
				esac

				read -p "Install parcellite (y/n)?" choice
				case "$choice" in
				y|Y ) install_parcellite;;
				n|N ) show_msg "\nSkipped parcellite !";;
				esac

				read -p "Install flameshot screenshot (y/n)?" choice
				case "$choice" in
				y|Y ) install_flameshot;;
				n|N ) show_msg "\nSkipped flameshot screenshot !";;
				esac

				read -p "Install ncdu (y/n)?" choice
				case "$choice" in
				y|Y ) install_ncdu;;
				n|N ) show_msg "\nSkipped ncdu !";;
				esac

				read -p "Install xfce profiles (y/n)?" choice
				case "$choice" in
				y|Y ) install_xfce_profiles;;
				n|N ) show_msg "\nSkipped xfce profiles !";;
				esac
				
				read -p "Install vlc (y/n)?" choice
				case "$choice" in
				y|Y ) install_vlc;;
				n|N ) show_msg "\nSkipped vlc !";;
				esac

				read -p "Install stacer (y/n)?" choice
				case "$choice" in
				y|Y ) install_stacer;;
				n|N ) show_msg "\nSkipped stacer !";;
				esac

				read -p "Install kazam (y/n)?" choice
				case "$choice" in
				y|Y ) install_kazam;;
				n|N ) show_msg "\nSkipped kazam !";;
				esac

				read -p "Install audacity (y/n)?" choice
				case "$choice" in
				y|Y ) install_audacity;;
				n|N ) show_msg "\nSkipped audacity !";;
				esac

				read -p "Install clamav (y/n)?" choice
				case "$choice" in
				y|Y ) install_clamav;;
				n|N ) show_msg "\nSkipped clamav !";;
				esac

				read -p "Install ffmpeg (y/n)?" choice
				case "$choice" in
				y|Y ) install_ffmpeg;;
				n|N ) show_msg "\nSkipped ffmpeg !";;
				esac

				read -p "Install remmina (y/n)?" choice
				case "$choice" in
				y|Y ) install_remmina;;
				n|N ) show_msg "\nSkipped remmina !";;
				esac

				read -p "Install grub customizer (y/n)?" choice
				case "$choice" in
				y|Y ) install_grub_customizer;;
				n|N ) show_msg "\nSkipped grub customizer !";;
				esac

				read -p "Install cifs utils (y/n)?" choice
				case "$choice" in
				y|Y ) install_cifs_utils;;
				n|N ) show_msg "\nSkipped cifs utils !";;
				esac

				read -p "Install gparted (y/n)?" choice
				case "$choice" in
				y|Y ) install_gparted;;
				n|N ) show_msg "\nSkipped gparted !";;
				esac

				read -p "Install wine (y/n)?" choice
				case "$choice" in
				y|Y ) install_wine;;
				n|N ) show_msg "\nSkipped wine !";;
				esac

				read -p "Install resolvconf (y/n)?" choice
				case "$choice" in
				y|Y ) install_resolvconf;;
				n|N ) show_msg "\nSkipped resolvconf !";;
				esac
				
				read -p "Install HP Printers (y/n)?" choice
				case "$choice" in
				y|Y ) install_hp_printers;;
				n|N ) show_msg "\nSkipped HP Printers !";;
				esac
				
				read -p "Install timeshift (y/n)?" choice
				case "$choice" in
				y|Y ) install_timeshift;;
				n|N ) show_msg "\nSkipped timeshift !";;
				esac
				
				read -p "Install peek (y/n)?" choice
				case "$choice" in
				y|Y ) install_peek;;
				n|N ) show_msg "\nSkipped peek !";;
				esac
				
				read -p "install Kubuntu Driver Manager (y/n)?" choice
				case "$choice" in
				y|Y ) install_kubuntu_driver_manager;;
				n|N ) show_msg "\nSkipped Kubuntu !";;
				esac
				
				read -p "install qapt deb installer (y/n)?" choice
				case "$choice" in
				y|Y ) install_qapt_deb_installer;;
				n|N ) show_msg "\nSkipped qapt deb installer !";;
				esac
				
				read -p "install nodejs (y/n)?" choice
				case "$choice" in
				y|Y ) install_nodejs;;
				n|N ) show_msg "\nSkipped nodejs !";;
				esac
				
				read -p "install libreoffice (y/n)?" choice
				case "$choice" in
				y|Y ) install_libreoffice;;
				n|N ) show_msg "\nSkipped libreoffice !";;
				esac
				
				read -p "install thunderbird (y/n)?" choice
				case "$choice" in
				y|Y ) install_thunderbird;;
				n|N ) show_msg "\nSkipped thunderbird !";;
				esac
				
				read -p "install nativefier (y/n)?" choice
				case "$choice" in
				y|Y ) install_nativefier;;
				n|N ) show_msg "\nSkipped nativefier !";;
				esac


		echo "Script ended !" & exit;;
		* ) show_msg "\nType y or n !!! \nScript ended" && exit;;
		esac