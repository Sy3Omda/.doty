#!/usr/bin/env bash
set -ue

# Shows colorful output messages.
show_msg () {
    echo -e '\e[32m'$1'\e[0m'
}

backup_kde_config_files(){
		# Check the path exists.
		[ -d "$HOME/.doty/kde" ] || mkdir -p "$HOME/.doty/kde"
		
		# Check if there already a Backup file.
		[ -f "$HOME/.doty/kde.tar.gz" ] && mv $HOME/.doty/kde.tar.gz $HOME/.doty/kde-old.tar.gz
		cd $HOME
		
		cp -vR --parents .config/albert/* -t $HOME/.doty/kde
		cp -vR --parents .config/autostart/* -t $HOME/.doty/kde
		cp -vR --parents .config/fontconfig/fonts.conf -t $HOME/.doty/kde
		cp -vR --parents .config/gtk-3.0/settings.ini -t $HOME/.doty/kde
		cp -vR --parents .config/Kvantum/* -t $HOME/.doty/kde
		cp -vR --parents .config/latte/* -t $HOME/.doty/kde
		cp -vR --parents .config/dolphinrc -t $HOME/.doty/kde
		cp -vR --parents .config/gtkrc -t $HOME/.doty/kde
		cp -vR --parents .config/gtkrc-2.0 -t $HOME/.doty/kde
		cp -vR --parents .config/kcminputrc -t $HOME/.doty/kde
		cp -vR --parents .config/kdeglobals -t $HOME/.doty/kde
		cp -vR --parents .config/konsolerc -t $HOME/.doty/kde
		cp -vR --parents .config/kscreenlockerrc -t $HOME/.doty/kde
		cp -vR --parents .config/ksplashrc -t $HOME/.doty/kde
		cp -vR --parents .config/kwinrc -t $HOME/.doty/kde
		cp -vR --parents .config/lattedockrc -t $HOME/.doty/kde
		cp -vR --parents .config/plasma-org.kde.plasma.desktop-appletsrc -t $HOME/.doty/kde
		cp -vR --parents .config/plasmarc -t $HOME/.doty/kde
		cp -vR --parents .config/plasmashellrc -t $HOME/.doty/kde
		cp -vR --parents .config/parcellite/parcelliterc -t $HOME/.doty/kde
		cp -vR --parents .config/kglobalshortcutsrc -t $HOME/.doty/kde
		cp -vR --parents .config/Dharkael/flameshot.ini -t $HOME/.doty/kde
		cp -vR --parents .config/terminator/* $HOME/.doty/kde
		cp -vR --parents .kde/share/apps/color-schemes/* -t $HOME/.doty/kde
		cp -vR --parents .kde/share/config/kdeglobals -t $HOME/.doty/kde
		cp -vR --parents .kde/share/apps/color-schemes/* -t $HOME/.doty/kde
		cp -vR --parents .local/share/plasma/{desktoptheme,look-and-feel,plasmoids,wallpapers} -t $HOME/.doty/kde
		cp -vR --parents /etc/sddm.conf.d/kde_settings.conf -t $HOME/.doty/kde
		cp -vR --parents /usr/share/sddm/themes/* -t $HOME/.doty/kde
		
		cd $HOME/.doty/kde && tar czvf $HOME/.doty/kde.tar.gz .config/ .kde/ .local/ usr/ etc/
		cd -
		
		show_msg "\nBackup Done"
		sleep 1
}

restore_kde_config(){
		if [ -f "$HOME/.doty/kde.tar.gz" ]
		then
			echo -e "\nConfig file found and restoring..." && tar xzvf $HOME/.doty/kde.tar.gz -C $HOME
		else
			echo -e "\nConfig file not found !"
		fi
}

restore_firefox(){
		# Deleting the whole Firefox Directory.
		[ -d "$HOME/.mozilla" ] && rm -rf "$HOME/.mozilla"
		# Check for backup file.
		if [ -f "$HOME/.doty/mozilla.tar.gz" ]
		then
			echo -e "\nMozilla file found and restoring..." && tar xzvf $HOME/.doty/mozilla.tar.gz -C $HOME
		else
			echo -e "\nMozilla file not found !"
		fi
}

install_dependencies_necessary_packages(){
		sudo apt update -y && sudo apt install -y git cmake g++ libx11-dev libxext-dev qtbase5-dev libqt5svg5-dev libqt5x11extras5-dev libkf5windowsystem-dev qttools5-dev-tools build-essential libkf5config-dev libkdecorations2-dev qtdeclarative5-dev extra-cmake-modules libkf5guiaddons-dev libkf5configwidgets-dev libkf5coreaddons-dev libkf5plasma-dev libsm-dev gettext extra-cmake-modules kwin-dev libdbus-1-dev sassc libcanberra-gtk-module libglib2.0-dev
		
		show_msg "Done."
		sleep 1
}

# Create a temp directory and run there
_TMP_DIR=$(mktemp -d)
cd $_TMP_DIR

install_kvantum(){
		# Compile and install Kvantum
		git clone https://github.com/tsujan/Kvantum.git
		cd Kvantum && cd Kvantum
		mkdir build && cd build
		cmake .. && make
		sudo make install
		
		show_msg "Done." && cd $_TMP_DIR
		sleep 1
}

install_sierra_breeze(){
		sudo add-apt-repository -y ppa:thopiekar/sierrabreeze
		sudo apt update -y && sudo apt install sierrabreeze -y
		
		show_msg "Done." && cd $_TMP_DIR
		sleep 1
}

install_latte_dock(){
		sudo apt -y install latte-dock
		
		show_msg "Done."
		sleep 1
}

install_albert(){
		echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
		curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_manuelschneid3r.gpg > /dev/null
		sudo apt update -y
		sudo apt install albert -y
		
		show_msg "Done."
		sleep 1
}

install_mojave_kde_themes(){
		show_msg "\nInstalling McMojave KDE Themes..."
		git clone https://github.com/vinceliuice/McMojave-kde.git mojave_kde
		cd mojave_kde
		# Necessary for Active Window Control applet.
		sudo mkdir -p /usr/local/share/aurorae/themes/
		sudo cp -r aurorae/* /usr/local/share/aurorae/themes/
		# Get back on track.
		./install.sh
		# Install SDDM theme.
		cd sddm && sudo ./install.sh
		
		show_msg "Done." && cd $_TMP_DIR
		sleep 1
}

install_mojave_circle_icon(){
		show_msg "\nInstalling McMojave-circle Icon Theme..."
		git clone https://github.com/vinceliuice/McMojave-circle.git
		cd McMojave-circle && ./install.sh
		
		show_msg "Done." && cd $_TMP_DIR
		sleep 1
}

install_whitesur_kde_theme(){
		show_msg "\nInstalling WhiteSur kde Theme..."
		git clone https://www.opencode.net/vinceliuice/WhiteSur-kde.git white_sure_theme
		cd white_sure_theme && ./install.sh
		
		show_msg "Done." && cd $_TMP_DIR
		sleep 1
}

install_whitesur_icon(){
		show_msg "\nInstalling WhiteSur Icon..."
		git clone https://github.com/vinceliuice/WhiteSur-icon-theme white_sure_icon
		cd white_sure_icon && ./install.sh
		
		show_msg "Done." && cd $_TMP_DIR
		sleep 1
}

install_whitesur_cursors(){
		show_msg "\nInstalling WhiteSur cursors..."
		git clone https://github.com/vinceliuice/WhiteSur-cursors whitesur_cursors
		cd whitesur_cursors && ./install.sh
		
		show_msg "Done." && cd $_TMP_DIR
		sleep 1
}

install_capitaine_cursors(){
		show_msg "\nInstalling Capitaine Cursors..."
		mkdir -p $HOME/.icons
		git clone https://github.com/keeferrourke/capitaine-cursors.git
		sudo apt install inkscape x11-apps -y
		cd capitaine-cursors && ./build.sh
		mkdir -p $HOME/.icons/capitaine-cursor
		cp -pr dist/ $HOME/.icons/capitaine-cursors
		
		show_msg "Done." && cd $_TMP_DIR
		sleep 1
}

install_sf_mono_font(){
		show_msg "\nInstalling SF Mono Font..."
		mkdir -p $HOME/.fonts/SFMono
		git clone https://github.com/ZulwiyozaPutra/SF-Mono-Font.git
		cp SF-Mono-Font/SFMono-* $HOME/.fonts/SFMono
		
		show_msg "Done." && cd $_TMP_DIR
		sleep 1
}

install_catalina_dynamic_wallpaper(){
		show_msg "\nDownloading Catalina Dynamic Wallpaper..."
		git clone https://github.com/caglarturali/catalina-dynamic-wallpaper.git
		cd catalina-dynamic-wallpaper
		chmod +x install && ./install --kde
		
		show_msg "Done." && cd $_TMP_DIR
		sleep 1
}

install_netspeed_widget(){
		git clone https://github.com/dfaust/plasma-applet-netspeed-widget.git
		cd plasma-applet-netspeed-widget
		mkdir build && cd build
		cmake -DCMAKE_INSTALL_PREFIX=/usr ..
		make &&	sudo make install
		
		show_msg "Done." && cd $_TMP_DIR
		sleep 1
}

install_redshift(){
		sudo apt install redshift qml-module-qtgraphicaleffects -y
		git clone https://github.com/KDE/plasma-redshift-control.git
		cd plasma-redshift-control
		mkdir build && cd build
		cmake .. -DCMAKE_INSTALL_PREFIX=/usr
		make && sudo make install
		
		show_msg "Done." && cd $_TMP_DIR
		sleep 1
}

delete_temporary_directory(){
		show_msg "\nCleaning up..."
		sudo rm -rf $_TMP_DIR
		show_msg "\nInstallation complete!\nIt's recommended to restart your computer immediately for the changes to take effect."
		sleep 1
}

######################################################################
#########################Beginning of Choices#########################
######################################################################

		read -p "Install Install Necessary Packages (y/n)?" choice
		case "$choice" in
		y|Y ) install_dependencies_necessary_packages;;
		n|N ) show_msg "\nSkipped Install Necessary Packages !";;
		* ) show_msg "\nType y or n." && show_msg "Skipped !";;
		esac
		
		read -p "Install Complete WhiteSure Theme & icons (y/n)?" choice
		case "$choice" in
		y|Y ) install_sf_mono_font && install_whitesur_kde_theme && install_whitesur_icon && install_whitesur_cursors && install_capitaine_cursors;;
		n|N ) show_msg "\nSkipped Install Complete Mojave Theme & icons !";;
		* ) show_msg "\nType y or n." && show_msg "Skipped !";;
		esac
		
		read -p "Install Complete Mojave Theme & icons (y/n)?" choice
		case "$choice" in
		y|Y ) install_sf_mono_font && install_sierra_breeze && install_mojave_kde_themes && install_mojave_circle_icon && install_catalina_dynamic_wallpaper;;
		n|N ) show_msg "\nSkipped Install Complete Mojave Theme & icons !";;
		* ) show_msg "\nType y or n." && show_msg "Skipped !";;
		esac
		
		read -p "Install Necessary Programs (y/n)?" choice
		case "$choice" in
		y|Y ) install_kvantum && install_latte_dock && install_albert && install_redshift && install_netspeed_widget;;
		n|N ) show_msg "\nSkipped Install Kvantum !";;
		* ) show_msg "\nType y or n." && show_msg "Skipped !";;
		esac
		
		read -p "Backup KDE Config Files (y/n)?" choice
		case "$choice" in
		y|Y ) backup_kde_config_files;;
		n|N ) show_msg "\nSkipped Backup KDE Config Files !";;
		* ) show_msg "\nType y or n." && show_msg "Skipped !";;
		esac
		
		read -p "Restore KDE Config files & dotfiles... (y/n)?" choice
		case "$choice" in
		y|Y ) restore_kde_config;;
		n|N ) show_msg "\nSkipped Restore KDE Config !";;
		* ) show_msg "\nType y or n." && show_msg "Skipped !";;
		esac
		
		read -p "Restore firefox [this will delete the old firefox directory](y/n)?" choice
		case "$choice" in
		y|Y ) restore_firefox;;
		n|N ) show_msg "\nSkipped Restore firefox !";;
		* ) show_msg "\nType y or n." && show_msg "Skipped !";;
		esac
		
delete_temporary_directory