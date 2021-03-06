#!/bin/bash
RELEASE_BOKEBENDI='E:\hexoBoKe\hexo-'
FUWUQI_BOKE='/root/panboke'
FUWUQI_URL='47.107.96.22'
FUWUQI_USER='root'
cd $RELEASE_BOKEBENDI
cd ..
PASSWORD=$(pwd)/'pass.txt'
#代码提交更新
bendi(){
	echo '本地更新代码并提交代码'
	cd $RELEASE_BOKEBENDI
	git pull
	echo '提交代码到本地.......'
	git add .
	git commit -m "脚本提交代码">>commit.log
	echo '拉取代码......'
	git pull>>pull.log
	echo '推送代码到git......'
	git push>>push.log
	pwd
}
#上传服务器并刷新
fuwuqi(){
echo '连接阿里云服务器。。。。。。'
ssh $FUWUQI_USER@$FUWUQI_URL << remotessh
	echo '连接上服务器......'
	cd $FUWUQI_BOKE
	echo '服务器提交代码到本地'
	git add .
	git commit -m "脚本提交代码"
	echo '拉取代码......'
	git pull>>pull.log
	echo '推送代码到git......'
	git push
	echo '重新编译hexo'
	hexo g -d
	echo '完成,退出服务器........'
	exit
remotessh
}
echo '代码提交到git.....'
bendi
echo '服务器从git拉取代码.............'
fuwuqi
echo '更新本地和远程一致避免冲突。。。。。。'
bendi
echo '操作完成。。。。。'
echo '按任意键退出...............
read