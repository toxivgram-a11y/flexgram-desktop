set -e
# FlexGram: same as desktop-app/patches build_libvpx_win.sh, but uses
# $TOOLCHAIN instead of $TARGET. The uppercase TARGET env var collides with
# the lowercase 'target' variable produced by libvpx makefiles, which makes
# MSBuild fail with MSB6001 "Item has already been added. Key ... 'target'".
FullExecPath=$PWD
pushd `dirname $0` > /dev/null
FullScriptPath=`pwd`
popd > /dev/null

pacman --noconfirm -Sy
pacman --noconfirm -S msys/make
pacman --noconfirm -S diffutils

./configure --prefix=$FullScriptPath/../local \
--target=$TOOLCHAIN \
--disable-examples \
--disable-unit-tests \
--disable-tools \
--disable-docs \
--enable-static-msvcrt \
--enable-vp8 \
--enable-vp9 \
--enable-webm-io

make -j8
make -j8 install
