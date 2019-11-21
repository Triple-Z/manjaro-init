#!/bin/bash
# This shell script is for Manjaro quick initialization.

function help() {
    echo "
 Usage:
   ./init.sh        Run this magical shell script!

"
}

function cn_mirror() {
    sudo pacman-mirrors -i -c China -m rank
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
}

function sogoupinyin() {
    sudo pacman -S fcitx fcitx-qt4 fcitx-im  fcitx-configtool fcitx-sogoupinyin --noconfirm

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
    # TODO: edit plugins & save
    # plugins=(git zsh-syntax-highlighting docker docker-compose zsh-autosuggestions zsh-completions)

    # autoload -U compinit && compinit
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

function tim() {
    yay -S deepin-wine-tim --noconfirm

    # Set DPI configuration:
    # - Set DPI as 120 in "Graphics" tab.
    env WINEPREFIX="$HOME/.deepinwine/Deepin-TIM" winecfg
}

function wechat() {
    yay -S deepin-wine-wechat --noconfirm

    # Set DPI configuration:
    # - Set DPI as 120 in "Graphics" tab.
    env WINEPREFIX="$HOME/.deepinwine/Deepin-WeChat" winecfg
}

function thunder_speed() {
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

