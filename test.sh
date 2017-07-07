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
        (time make -j$c) &> ../busybox-$c-$(date +%s).log
        cd ..
        rm -rf busybox-1.27.0

        echo LINUX CORE COUNT $c - TRY COUNT $i
        tar -xf linux-4.12.tar.xz
        cd linux-4.12
        (make defconfig) &> /dev/null
        (time make -j$c) &> ../linux-$c-$(date +%s).log
        cd ..
        rm -rf linux-4.12

        echo COREUTILS CORE COUNT $c - TRY COUNT $i
        tar -xf coreutils-8.27.tar.xz
        cd coreutils-8.27
        (./configure) &> /dev/null
        (time make -j$c) &> ../coreutils-$c-$(date +%s).log
        cd ..
        rm -rf coreutils-8.27
        
        echo CLANG CORE COUNT $c - TRY COUNT $i
        tar -xf llvm-4.0.1.src.tar.xz
        tar -xf cfe-4.0.1.src.tar.xz
        tar -xf clang-tools-extra-4.0.1.src.tar.xz
        tar -xf compiler-rt-4.0.1.src.tar.xz
        
        mv llvm-4.0.1.src llvm
        mv cfe-4.0.1.src llvm/tools/clang
        mv clang-tools-extra-4.0.1.src llvm/tools/clang/tools/extra
        mv compiler-rt-4.0.1.src llvm/projects/compiler-rt
        
        mkdir build-clang
        cd build-clang
        (cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ../llvm) &> /dev/null
        (time make -j$c) &> ../clang-$c-$(date +%s).log
        cd ..
        rm -rf llvm
        rm -rf build-clang
    done
done
