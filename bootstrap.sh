sudo apt-get build-dep linux-image-`uname -r` busybox coreutils cmake
sudo apt-get install curl build-essential
curl https://www.busybox.net/downloads/busybox-1.27.0.tar.bz2 > busybox-1.27.0.tar.bz2
curl https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.12.tar.xz > linux-4.12.tar.xz
curl https://ftp.gnu.org/gnu/coreutils/coreutils-8.27.tar.xz > coreutils-8.27.tar.xz
curl https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz > Python-3.6.1.tgz
curl https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz > Python-2.7.13.tgz
