#!/bin/bash
# Author:               TripleZ <me@triplez.cn>
# Maintainer:           TripleZ <me@triplez.cn>
# Last Updated:         2020-02-06
#
# This shell script is for Manjaro quick initialization.

function help() {
    echo "
 Usage:
   ./init.sh        Run this magical shell script!

"
}

function cn_mirror() {
    # using fixed mirror
    sudo pacman-mirrors -c China -m rank
    sudo echo "[archlinuxcn]
SigLevel= TrustedOnly
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
" >> /etc/pacman.conf
    # Install archlinuxcn keyring
    sudo pacman -Syu archlinuxcn-keyring  --noconfirm
}

function update_system() {
    sudo pacman -Syyu --noconfirm
}

function set_local_time() {
    sudo timedatectl set-local-rtc true
}

function essentials() {
    sudo pacman -S yay git net-tools tree vim htop --noconfirm
}

function laptop_gpu_switch() {
    sudo pacman -S virtualgl lib32-virtualgl lib32-primus primus --noconfirm
    sudo systemctl enable bumblebeed
    sudo gpasswd -a $USER bumblebee
}

function emoji() {
    sudo pacman -S noto-fonts-emoji --noconfirm
}

function shadowsocks() {
    sudo pacman -S shadowsocks-qt5 --noconfirm
}

function electron_ssr() {
    yay -S electron-ssr --noconfirm
}

function proxychains() {
    sudo pacman -S proxychains-ng --noconfirm

    sudo echo "socks5 127.0.0.1 1080" >> /etc/proxychains.conf
}

function privoxy() {
    sudo pacman -S privoxy --noconfirm

    sudo echo "forward-socks5 / 127.0.0.1:1080 ." >> /etc/privoxy/config

    sudo systemctl restart privoxy
    sudo systemctl enable privoxy
}

function input_method() {
    # install RIME and Sogou Pinyin
    # Sogou Pinyin is so unstable that I recommand to use RIME.

    sudo pacman -S fcitx fcitx-qt4 fcitx-im fcitx-configtool fcitx-sogoupinyin fcitx-rime fcitx-cloudpinyin fcitx-googlepinyin --noconfirm

    echo "export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx" >> ~/.xprofile

    # Install Chinese fonts
    sudo pacman -S wqy-bitmapfont wqy-microhei \
  wqy-zenhei adobe-source-code-pro-fonts \
  adobe-source-han-sans-cn-fonts ttf-monaco --noconfirm
}

function telegram() {
    sudo pacman -S telegram-desktop --noconfirm
}

function dropbox() {
    yay -S dropbox --noconfirm
}

function nutstore() {
    sudo pacman -S nutstore --noconfirm
}

function typora() {
    sudo pacman -S typora --noconfirm
}

function oh_my_zsh() {
    sudo pacman -S zsh --noconfirm
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function oh_my_zsh_extensions() {
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/plugins/zsh-completions

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

    # vim ~/.zshrc
    # edit plugins & save
    # plugins=(git zsh-syntax-highlighting docker docker-compose zsh-autosuggestions zsh-completions)    
    sed -i '/^plugins/c\plugins=(git zsh-syntax-highlighting docker docker-compose zsh-autosuggestions zsh-completions)' ~/.zshrc

    autoload -U compinit && compinit
}

function chrome() {
    sudo pacman -S google-chrome --noconfirm
}

function netease_cloud_music() {
    sudo pacman -S netease-cloud-music --noconfirm
}

function mailspring() {
    yay -S mailspring --noconfirm
    sudo pacman -S libsecret --noconfirm
}

function deepin_wine() {
    sudo pacman -S deepin-wine --noconfirm

    # 修复字体发虚
    yay -S lib32-freetype2-infinality-ultimate --noconfirm

    sudo pacman -Sy gnome-settings-daemon --noconfirm
    cp /etc/xdg/autostart/org.gnome.SettingsDaemon.XSettings.desktop ~/.config/autostart
}

function tim() {
    yay -S deepin-wine-tim --noconfirm

    # TODO: Change wine container to deepin-wine

    # Set DPI configuration:
    # - Set DPI as 120 in "Graphics" tab.
    env WINEPREFIX="$HOME/.deepinwine/Deepin-TIM" winecfg
}

function wechat() {
    yay -S deepin-wine-wechat --noconfirm

    # TODO: Change wine container to deepin-wine

    # Set DPI configuration:
    # - Set DPI as 120 in "Graphics" tab.
    # TODO: it won't work!
    # env WINEPREFIX="$HOME/.deepinwine/Deepin-WeChat" winecfg
}

function thunder_speed() {
    # TODO: Change wine container to deepin-wine

    yay -S deepin-wine-thunderspeed --noconfirm
}

function uget_aria2() {
    sudo pacman -S uget aria2 --noconfirm
}

function wps_office() {
    sudo pacman -S ttf-wps-fonts wps-office --noconfirm
}

# Redshift for night light (ONLY for KDE)
function redshift() {
    yay -S redshift --noconfirm
}

function deepin_screenshot() {
    yay -S deepin-screenshot --noconfirm
}

function awesome_vimrc() {
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
}

function git_config() {
    git config --global user.name "$GIT_USERNAME"
    git config --global user.email "$GIT_USEREMAIL"
    git config --global core.editor vim

    # TODO: Create & set GPG keys
}

function meld() {
    # Meld is a visual diff and merge tool targeted at developers.
    sudo pacman -S meld --noconfirm

    # set meld as the default GUI diff tool
    git config --global diff.guitool meld

    # set meld as git defualt merge tool
    git config --global merge.tool meld
}

function docker() {
    sudo pacman -S docker docker-compose --noconfirm
}

function jre() {
    sudo pacman -S java-runtime-common java-environment-common --noconfirm
}

function jdk8() {
    # Select extra/jdk8-openjdk
    # yay jdk8
    # TODO: validate
    yay -S jdk8-openjdk --noconfirm

    # set jdk8
    sudo archlinux-java set java-8-jdk
}

function list_java_env() {
    archlinux-java status
}

function go() {
    sudo pacman -S go go-tools --noconfirm

    echo "export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
" >> ~/.zshrc
}

function goproxy_cn() {
    echo "export GOPROXY=https://goproxy.cn" >> ~/.zshrc
}

function mariadb() {
    sudo pacman -S mariadb --noconfirm
    # Install MariaDB
    sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
}

function mariadb_config() {
    # start MariaDB
    sudo systemctl start mariadb
    # config MariaDB using interactive wizard
    sudo mysql_secure_installtion

    # set default character set as utf8mb4
    sudo echo "[client]
default-character-set = utf8mb4

[mysqld]
collation_server = utf8mb4_unicode_ci
character_set_server = utf8mb4

[mysql]
default-character-set = utf8mb4
" >> /etc/my.cnf

    sudo systemctl restart mariadb
}

function redis() {
    sudo pacman -S redis --noconfirm
    sudo systemctl start redis
}

function vscode() {
    sudo pacman -S visual-studio-code-bin --noconfirm
}

function sublime_text() {
    yay -S sublime-text-dev --noconfirm
}

function jetbrains_toolbox() {
    yay -S jetbrains-toolbox --noconfirm
}

function postman() {
    yay -S postman --noconfirm
}

function latte_dock() {
    sudo pacman -S latte-dock --noconfirm
}

function global_menu() {
    sudo pacman -S appmenu-gtk-module libdbusmenu-glib --noconfirm
}

function adapta_theme() {
    yay -S adapta-kde kvantum-theme-adapta adapta-gtk-theme --noconfirm
}

function draw_io() {
    yay -S drawio-desktop --noconfirm
}

function main() {
    # load the configuration
    . ./config

    for STEP in ${STEPS[@]}
    do
	echo "------------- $STEP -------------------"
        $STEP
    done
    # help
}

main

