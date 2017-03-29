#!/bin/sh
function pause(){
   read -p "$*"
}

# Original Concept by Duran Keeley
# Modified and updated by Shaneee

# Accept Xcode EULA
sudo xcodebuild -license accept

# Install Xcode Command Line Tools
xcode-select --install 
set -e

pause 'Press [Enter] key to continue...'

pushd `dirname $0` > /dev/null
CURRENT_DIR=`pwd`
popd > /dev/null

SDK_ROOT=`xcodebuild -version -sdk macosx Path`
LIBDISPATCH_DIR_NAME="libdispatch-703.30.5"
echo "Installing libdispatch-703.30.5"

TARGET_HEADER_DIR="${SDK_ROOT}/usr/local/include/kernel/os"
TARGET_LIB_DIR="${SDK_ROOT}/usr/local/lib/kernel"

mkdir -p "${TARGET_HEADER_DIR}"
mkdir -p "${TARGET_LIB_DIR}"

cp -rf "${CURRENT_DIR}/${LIBDISPATCH_DIR_NAME}/firehose_buffer_private.h" "${TARGET_HEADER_DIR}/"
cp -rf "${CURRENT_DIR}/${LIBDISPATCH_DIR_NAME}/libfirehose_kernel.a" "${TARGET_LIB_DIR}/"

echo "libdispatch-703.30.5 Installed"

pause 'Press [Enter] key to continue...'

echo "Installing dtrace-209.20.4"
echo "  "
cd dtrace-209.20.4
mkdir -p obj sym dst
xcodebuild install -target ctfconvert -target ctfdump -target ctfmerge ARCHS="x86_64" SRCROOT=$PWD OBJROOT=$PWD/obj SYMROOT=$PWD/sym DSTROOT=$PWD/dst
sudo ditto $PWD/dst/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain
cd ..

pause 'Press [Enter] key to continue...'

echo "Installing AvailabilityVersions-26.30.3"
cd AvailabilityVersions-26.30.3
mkdir -p dst
make install SRCROOT=$PWD DSTROOT=$PWD/dst
sudo ditto $PWD/dst/usr/local `xcrun -sdk macosx -show-sdk-path`/usr/local
cd ..

echo "Finished. Your system is now able to build the Sierra XNU Kernel."
echo "Visit http://amd-osx.com/"