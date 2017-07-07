sudo apt-get build-dep linux-image-`uname -r` busybox coreutils
sudo apt-get install curl build-essential
curl https://www.busybox.net/downloads/busybox-1.27.0.tar.bz2 > busybox-1.26.2.tar.bz2
curl https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.12.tar.xz > linux-4.10.12.tar.xz
curl https://ftp.gnu.org/gnu/coreutils/coreutils-8.27.tar.xz > coreutils-8.27.tar.xz
