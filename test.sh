(getconf _NPROCESSORS_ONLN) &> cores.log

for i in {1..8}
do
    for i in {1..10}
    do
        tar -xf busybox-1.26.2.tar.bz2
        cd busybox-1.26.2
        make defconfig
        (time make -j1) &> busybox-$(date +%s).log
        cd ..
        rm -rf busybox-1.26.2

        tar -xf linux-4.10.12.tar.xz
        cd linux-4.10.12
        make defconfig
        (time make -j1) &> linux-$(date +%s).log
        cd ..
        rm -rf linux-4.10.12

        tar -xf coreutils-8.27.tar.xz
        cd coreutils-8.27
        ./configure
        (time make -j1) &> coreutils-$(date +%s).log
        cd ..
        rm -rf coreutils-8.27
    done
done