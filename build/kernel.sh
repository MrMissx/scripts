#!bin/bash
IMAGE=$(pwd)/out/arch/arm64/boot/Image.gz-dtb
echo "Clone Toolchain, Anykernel and GCC"
git clone -j32 https://github.com/keselekpermen69/AnyKernel3 -b master AnyKernel
git clone -j32 --depth=1 https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 toolchain
git clone -j32 --depth=1 https://github.com/kdrag0n/proton-clang -b master clang
echo "Done"
token=$(openssl enc -base64 -d <<< MTA3NzgyOTIxOTpBQUZ4OFBJYzMtVjhSb3FidXc2LXl4Q20wVnZvRlUxbUxQbw==)
chat_id="-1001386076951"
branch=$(git rev-parse --abbrev-ref HEAD)
GCC="$(pwd)/gcc/bin/aarch64-linux-gnu-"
builddate=$(TZ=Asia/Jakarta date +'%H%M-%d%m%y')
START=$(date +"%s")
export LD_LIBRARY_PATH="/root/clang/bin/../lib:$PATH"xport ARCH=arm64
export KBUILD_BUILD_USER=KeselekPermen69
export KBUILD_BUILD_HOST=CircleCI
# sticker
function sticker() {
        curl -s -X POST "https://api.telegram.org/bot$token/sendSticker" \
                        -d sticker="CAACAgUAAx0CUGAGVgACHrVels7L-VFrDDRSkhF91C-xjNr_9gACGgIAAiP4CjQujWf62uWo8xgE" \
                        -d chat_id=$chat_id
}
# Sticker Error
function stikerr() {
	curl -s -F chat_id=$chat_id -F sticker="CAACAgUAAx0CUGAGVgACH2RetQdhikSG4I964z77S74lTtMBSAACOwIAAiP4CjQ0b-ii4MiaRxkE" https://api.telegram.org/bot$token/sendSticker
}
# Send info to channel
function sendinfo() {
        PATH="/root/clang/bin:${PATH}"
        curl -s -X POST "https://api.telegram.org/bot$token/sendMessage" \
                        -d chat_id=$chat_id \
                        -d "disable_web_page_preview=true" \
                        -d "parse_mode=html" \
                        -d text="New Build is UP!%0A<b>Started on :</b> <code>CircleCI</code>%0A<b>Device :</b> <code>Lavender(Redmi Note 7/7S)</code>%0A<b>Kernel Version :</b> <code>$(make kernelversion)</code>%0A<b>Branch :</b> <code>$(git rev-parse --abbrev-ref HEAD)</code>%0A<b>Under commit :</b> <code>$(git log --pretty=format:'"%h : %s"' -1)</code>%0A<b>Compiler :</b> <code>$($(pwd)/clang/bin/clang --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g')</code>%0A<b>Started on :</b> <code>$(TZ=Asia/Jakarta date)</code>"
}
# Push kernel to channel
function push() {
        cd AnyKernel
	ZIP=$(echo *.zip)
	curl -F document=@$ZIP "https://api.telegram.org/bot$token/sendDocument" \
			-F chat_id="$chat_id" \
			-F "disable_web_page_preview=true" \
			-F "parse_mode=html" \
			-F caption="Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s)."
}
# Upload build log to channel
function paste() {
        cat build.log | curl -F document=@build.log "https://api.telegram.org/bot$token/sendDocument" \
			-F chat_id="$chat_id" \
			-F "disable_web_page_preview=true" \
			-F "parse_mode=html" 
}
# Fin Error
function finerr() {
        paste
        curl -s -X POST "https://api.telegram.org/bot$token/sendMessage" \
			-d chat_id="$chat_id" \
			-d "disable_web_page_preview=true" \
			-d "parse_mode=markdown" \
			-d text="Build throw an error(s) :'("
}
# Compile plox
function compile() {
make O=out ARCH=arm64 lavender-perf_defconfig
PATH="${PWD}/bin:${PWD}/toolchain/bin:${PATH}:${PWD}/clang/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=arm-linux-gnueabi- | tee build.log
            if ! [ -a $IMAGE ]; then
                finerr
		stikerr
                exit 1
            fi
        cp out/arch/arm64/boot/Image.gz-dtb AnyKernel/zImage
}
# Zipping
function zipping() {
        cd AnyKernel
        zip -r9 Ini_Kernel-${branch}-${builddate}.zip *
        cd ..
}
sendinfo
compile
zipping
END=$(date +"%s")
DIFF=$(($END - $START))
paste
push
sticker