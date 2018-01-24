set -e
(nproc) &> cores.log

for c in {1..8}
do
    for i in {1..10}
    do
        echo BUSYBOX CORE COUNT $c - TRY COUNT $i
        tar -xf busybox-1.27.0.tar.bz2
        cd busybox-1.27.0
        (make defconfig) &> /dev/null
        (time -v make -j$c) &> ../busybox-$c-$(date +%s).log
        cd ..
        rm -rf busybox-1.27.0

        #echo LINUX CORE COUNT $c - TRY COUNT $i
        #tar -xf linux-4.12.tar.xz
        #cd linux-4.12
        #(make defconfig) &> /dev/null
        #(time -v make -j$c) &> ../linux-$c-$(date +%s).log
        #cd ..
        #rm -rf linux-4.12

        echo COREUTILS CORE COUNT $c - TRY COUNT $i
        tar -xf coreutils-8.27.tar.xz
        cd coreutils-8.27
        (./configure) &> /dev/null
        (time -v make -j$c) &> ../coreutils-$c-$(date +%s).log
        cd ..
        rm -rf coreutils-8.27
        
        echo PYTHON 3 CORE COUNT $c - TRY COUNT $i
        tar -xf Python-3.6.1.tgz
        cd Python-3.6.1
        (./configure) &> /dev/null
        (time -v make -j$c) &> ../python3-$c-$(date +%s).log
        cd ..
        rm -rf Python-3.6.1
        
        echo PYTHON 2 CORE COUNT $c - TRY COUNT $i
        tar -xf Python-2.7.13.tgz
        cd Python-2.7.13
        (./configure) &> /dev/null
        (time -v make -j$c) &> ../python2-$c-$(date +%s).log
        cd ..
        rm -rf Python-2.7.13
    done
done
