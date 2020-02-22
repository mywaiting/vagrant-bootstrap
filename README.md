# Vagrant Bootstrap

方便使用，居家旅行，开发测试 PYTHON/PHP 环境  必备的初始化文件！


> 经过实际的测试
> **中国大陆的网络内，初始化并且完成配置开发环境能在分钟级别完成**
> 前提是网络足够好

------------------

本配置文件采用官方的 box 镜像 `ubuntu/xenial64`，使用前先运行 `vagrant box add ubuntu/xenial64` 进行添加。

由于中国大陆的 `vagrant box` 源下载速度极慢，所以可以考虑使用清华 TUNA 源代替，下面的 Ubuntu 系统版本请自行选择，默认安装的是 `ubuntu/xenial64` 经过几次大补丁，这是目前（2020/02/22）最稳定的 ubuntu LTS 版本，没有之一。


```
#
# ubuntu 14.04 LTS/amd64
# Vagrantfile 对应 config.vm.box = "ubuntu/trusty64"
#
vagrant init ubuntu/trusty64
vagrant box add https://mirrors.tuna.tsinghua.edu.cn/ubuntu-cloud-images/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box --name ubuntu/trusty64
vagrant up

#
# ubuntu 16.04 LTS/amd64
# Vagrantfile 对应 config.vm.box = "ubuntu/xenial64"
#
vagrant init ubuntu/xenial64
vagrant box add https://mirrors.tuna.tsinghua.edu.cn/ubuntu-cloud-images/xenial/current/xenial-server-cloudimg-amd64-vagrant.box --name ubuntu/xenial64
vagrant up

#
# ubuntu 18.04 LTS/amd64
# Vagrantfile 对应 config.vm.box = "ubuntu/bionic"
#
vagrant init ubuntu/bionic
vagrant box add https://mirrors.tuna.tsinghua.edu.cn/ubuntu-cloud-images/bionic/current/bionic-server-cloudimg-amd64-vagrant.box 
--name ubuntu/bionic
vagrant up
```

## 文件说明：

* `Vagrantfile`：Vagrant 的配置文件
* `bootstrap.sh`：镜像初始化后自动运行的脚本，顺带说明，此脚本只会在第一次运行`vagrant up`的时候运行，之后不会自动运行！
* `sources.list.mirror`：Ubuntu APT 源镜像服务器，此处使用 TUNA 的镜像服务器在中国大陆内进行加速，默认是 `ubuntu/xenial64` 的更新源，需要其他系统版本源的，请自行去除注释即可
* `pip.conf`：Python PyPI 源镜像服务器，此处使用 TUNA 的镜像服务器在中国大陆内进行加速
* `./pythonenv-installer.sh` 自动安装好所有关于 Python 的开发环境。由于 `pyenv-installer.sh` 文件经常被墙，这里直接放进文件夹，最新的 `pyenv-installer.sh` 请自行访问 Pyenv 官方仓库获得
* `./phpenv-installer.sh` 自动安装 PHP 开发环境

环境版本：`Vagrant 2.2.*`， `VirtualBox 6.0.*` 

## `bootstrap.sh` 文件说明：

需要单独说明一下 `bootstrap.sh`这个文件的内容，内容分为几个部分，大体上是

* 系统设置，如设置 APT 源镜像服务器等，`resolvconf`等
* 安装包设置，这个根据自己需要定制，通常我需要安装 `mysql-server`，`redis-server` 等

## PYTHON 开发环境配置说明

由于 `Pyenv install $version$` 是采用编译 Python 源代码实现的，所以必须保证下面的包都有提前安装，必须保证！

```

# for compile python source
apt-get install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev 
apt-get install -y libsqlite3-dev libffi-dev libncurses5-dev libcurl4-openssl-dev 
apt-get install -y libmysqlclient-dev python-dev 

```

- 开发环境设置，这个同样需要根据自己定制，我主要用`python`，可以使用 `vagrant ssh`  执行 `./pythonenv-installer.sh` 会自动安装好所有关于 Python 的开发环境，包括
	- `pyenv` 自动选择国内的 `python build mirrors` 安装速度极其快
	- `pip proxy` 全局将 `pip` 安装源指向 TUNA 的 pip 安装源
	- `python 3.8.1` `virtualenv 3.8.1`  最新的 Python 3.8 开发环境
	- `python 2.7.17` `virtualenv 2.7.17`  最新的 Python 2.7 开发环境

- 个人设置，这里是纯粹个人的设置，怎么需要，怎么喜欢，自己来

## PHP 开发环境配置说明

- 需要安装 PHP 开发环境的同学请自行执行 `./phpenv-installer.sh` 
	- 自带 nginx wordpress 的配置文件
	- 自带 nginx typecho 的配置文件
- 个人设置，这里是纯粹个人的设置，怎么需要，怎么喜欢，自己来

## 备注

这是我个人使用的 `vagrantfile`，自己方便着想，如果需要可以自行 fork 定制使用。谢谢！
