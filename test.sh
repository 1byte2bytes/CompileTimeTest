(nproc) &> cores.log

for c in {1..$(nproc)}
do
    for i in {1..10}
    do
        echo BUSYBOX CORE COUNT $c - TRY COUNT $i
        tar -xf busybox-1.26.2.tar.bz2
        cd busybox-1.26.2
        (make defconfig) &> /dev/null
        (time make -j$c) &> ../busybox-$c-$(date +%s).log
        cd ..
        rm -rf busybox-1.26.2

        echo LINUX CORE COUNT $c - TRY COUNT $i
        tar -xf linux-4.10.12.tar.xz
        cd linux-4.10.12
        (make defconfig) &> /dev/null
        (time make -j$c) &> ../linux-$c-$(date +%s).log
        cd ..
        rm -rf linux-4.10.12

        echo COREUTILS CORE COUNT $c - TRY COUNT $i
        tar -xf coreutils-8.27.tar.xz
        cd coreutils-8.27
        (./configure) &> /dev/null
        (time make -j$c) &> ../coreutils-$c-$(date +%s).log
        cd ..
        rm -rf coreutils-8.27
    done
done
