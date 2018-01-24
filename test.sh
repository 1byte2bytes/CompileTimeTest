set -e
(nproc) &> cores.log

for c in {1..8}
do
    for i in {1..10}
    do
        tar -xf busybox-1.27.0.tar.bz2
        cd busybox-1.27.0
        make defconfig
        echo BUSYBOX CORE COUNT $c - TRY COUNT $i
        (/usr/bin/time -f "%E %P %M" make -j$c) &> ../busybox-$c-$(date +%s).log
        cd ..
        rm -rf busybox-1.27.0

        echo LINUX CORE COUNT $c - TRY COUNT $i
        tar -xf linux-4.14.15.tar.xz
        cd linux-4.14.15
        (make defconfig) &> /dev/null
        (/usr/bin/time -f "%E %P %M" make -j$c) &> ../linux-$c-$(date +%s).log
        cd ..
        rm -rf linux-4.12

        tar -xf coreutils-8.27.tar.xz
        cd coreutils-8.27
        FORCE_UNSAFE_CONFIGURE=1 ./configure
        echo COREUTILS CORE COUNT $c - TRY COUNT $i
        (/usr/bin/time -f "%E %P %M" make -j$c) &> ../coreutils-$c-$(date +%s).log
        cd ..
        rm -rf coreutils-8.27
        
        tar -xf Python-3.6.1.tgz
        cd Python-3.6.1
        ./configure
        echo PYTHON 3 CORE COUNT $c - TRY COUNT $i
        (/usr/bin/time -f "%E %P %M" make -j$c) &> ../python3-$c-$(date +%s).log
        cd ..
        rm -rf Python-3.6.1
    done
done
