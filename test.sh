(getconf _NPROCESSORS_ONLN) &> cores.log

for c in {1..8}
do
    for i in {1..10}
    do
        echo BUSYBOX CORE COUNT $c - TRY COUNT $i
        tar -xf busybox-1.26.2.tar.bz2
        cd busybox-1.26.2
        (make defconfig) &> /dev/null
        (time make -j1) &> ../busybox-$c-$(date +%s).log
        cd ..
        rm -rf busybox-1.26.2

        echo LINUX CORE COUNT $c - TRY COUNT $i
        tar -xf linux-4.10.12.tar.xz
        cd linux-4.10.12
        (make defconfig) &> /dev/null
        (time make -j1) &> ../linux-$c-$(date +%s).log
        cd ..
        rm -rf linux-4.10.12

        echo COREUTILS CORE COUNT $c - TRY COUNT $i
        tar -xf coreutils-8.27.tar.xz
        cd coreutils-8.27
        (./configure) &> /dev/null
        (time make -j1) &> ../coreutils-$c-$(date +%s).log
        cd ..
        rm -rf coreutils-8.27
    done
done
