#!/usr/bin/env bash


# 
#
# Parts Below MUST execute as vagrant user or your development env user!!!!
# Parts Below MUST execute as vagrant user or your development env user!!!!
# Parts Below MUST execute as vagrant user or your development env user!!!!
# Parts Below MUST execute as vagrant user or your development env user!!!!
# Parts Below MUST execute as vagrant user or your development env user!!!!
# Parts Below MUST execute as vagrant user or your development env user!!!!
# 
# 


echo "--------------------------"
echo " Install PYTHON pyenv     "
echo "--------------------------"

# install pyenv
# sed $'s/\r$//' ./install.sh > ./install.Unix.sh # remove windows /r/n to unix /n
# 
cp /vagrant/pyenv-installer.sh ~/
chmod +x ~/pyenv-installer.sh
./pyenv-installer.sh
# export pyenv to ~/.bashrc
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"'               >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"'    >> ~/.bashrc
# execute pyenv direct
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


echo "--------------------------"
echo " Modify PYTHON pip source "
echo "--------------------------"

# use China pip source
# 
# pip install pip -U
# pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
# 
mkdir ~/.pip
bash -c "cat /vagrant/pip.conf > ~/.pip/pip.conf"


echo "--------------------------"
echo " Download PYTHON srcfiles "
echo "--------------------------"

# install python, use taobao CDN moirrors, Very Fast in China!!!
# 
# export PYTHON_BUILD_MIRROR_URL="https://npm.taobao.org/mirrors/python/"
# export PYTHON_BUILD_MIRROR_URL="http://mirrors.sohu.com/python/"
# 
# Before compile python, MUST INSTALL for python env, MUST!!! MUST!!!!
# apt-get install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev libncurses5-dev libcurl4-openssl-dev python-dev 
# 
mkdir ~/.pyenv/cache
# pyenv install 3.8.1
export v=3.8.1; wget https://npm.taobao.org/mirrors/python/$v/Python-$v.tar.xz -P ~/.pyenv/cache/; pyenv install $v
# pyenv install 2.7.17
export v=2.7.17; wget https://npm.taobao.org/mirrors/python/$v/Python-$v.tar.xz -P ~/.pyenv/cache/; pyenv install $v


echo "--------------------------"
echo " Install PYTHON 3.8.1     "
echo "--------------------------"

# 
# make develop folder, use Python 3.8.1, named '~/venv38', and Actived
# 
cd ~
pyenv virtualenv 3.8.1 venv38
pyenv activate venv38

# install python requirements
cat > ~/venv38.requirements << __EOF__
redis
mysql-connector-python
tornado
wtforms
mistune
__EOF__
pip install -r ~/venv38.requirements
pyenv deactivate


echo "--------------------------"
echo " Install PYTHON 2.7.17    "
echo "--------------------------"

# 
# make develop folder, use Python 2.7.17, named '~/venv27', and Actived
# 
cd ~
pyenv virtualenv 2.7.17 venv27
pyenv activate venv27
# mysql-python==1.2.5, only supported Python 2.7 and Python-3.0 will be supported in a future release. PyPy is supported.
# tornado==5.1  if compatibility with Python 2.7 is required
cat > ~/venv27.requirements << __EOF__
redis
mysql-python==1.2.5
tornado==5.1
wtforms
mistune
__EOF__
pip install -r ~/venv27.requirements
pyenv deactivate