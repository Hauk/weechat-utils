#!/bin/bash

#Ensure you have all the dependencies installed for cmake:
#Link: http://www.weechat.org/files/doc/stable/weechat_user.en.html#dependencies

#remove the old .tar.gz
#rm -rf ../../weechat-0.*.*.tar.gz

weechat_home="/home/hauk/weechat/"
install_dir=$weechat_home/build/
tar_build="weechat.tar.gz"
rb_weechat_home="/home/associat/h/hauk/weechat/"
rb_user="hauk"
rb_server="azazel.redbrick.dcu.ie"

#gzip sources from http://weechat.org/download/ Note: Update this url to the latest tar.gz.
wc_installer_url="http://weechat.org/files/src/weechat-0.4.2.tar.gz"

echo "Downloading: " $wc_installer_url  "..."

#Download the tar.gz to /home/hauk/weechat/
wget -m -nd $wc_installer_url -P $weechat_home

#Get the filename of the .tar.gz
weechat_tar=$(ls $weechat_home | grep "weechat-0.*.*.tar.gz")

echo "tar filename is: " $weechat_tar

#Untar the source tar.gz.
tar -zxvf $weechat_home$weechat_tar -C $weechat_home

weechat_untar=$(ls $weechat_home --ignore *.tar.gz | grep "weechat-0.*.*")

echo "weechat untarred directory is:" $weechat_untar

#create the build directory.
mkdir $weechat_home$weechat_untar/build/

#Run the build process.
cd $weechat_home$weechat_untar/build/

#Add all the flags to cmake
cmake .. -DPREFIX=$install_dir -DENABLE_ALIAS=ON -DENABLE_ASPELL=ON -DENABLE_CHARSET=ON -DENABLE_LUA=ON -DENABLE_IRC=ON -DNCURSES=ON -DENABLE_PYTHON=ON -DENABLE_RUBY=ON

#Run make
make

#And install it!
make install

#cd to weechat_home.
cd $weechat_home

#tar it up for transfer to azazazaaz.
tar -zcvf $tar_build build/

#SCP the tar to the users rb weechat folder.
scp weechat.tar.gz $rb_user@$rb_server:$rb_weechat_home
