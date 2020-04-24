#!bin/bash
IMAGE=$(pwd)/out/arch/arm64/boot/Image.gz-dtb
echo "Cloning Toolchain, and AnyKernel"
git clone --depth=1 https://github.com/kdrag0n/proton-clang -b master clang
git clone --depth=1 https://github.com/keselekpermen69/AnyKernel3 -b master AnyKernel
echo "Done"
token=$(openssl enc -base64 -d <<< MTA3NzgyOTIxOTpBQUZ4OFBJYzMtVjhSb3FidXc2LXl4Q20wVnZvRlUxbUxQbw==)
chat_id="-1001386076951"
codename_device=lavender
branch=$(git rev-parse --abbrev-ref HEAD)
PATH=$(pwd)/clang/bin:$PATH
curl -s -X POST https://api.telegram.org/bot$token/sendMessage?chat_id=$chat_id -d "disable_web_page_preview=true" -d "parse_mode=html&text=New build is up"'!'"%0A<b>Started on:</b> <code>CircleCI</code>%0A<b>Device:</b> Lavender(Redmi Note 7/7S AOSP)%0A<b>Branch:</b> <code>$(git rev-parse --abbrev-ref HEAD)</code>%0A<b>Latest commit:</b> <code>$(git log --pretty=format:'"%h : %s"' -1)</code>%0A<b>Toolchain:</b> <code>$($(pwd)/clang/bin/clang --version)</code>%0A<b>Started at:</b> <code>$(TZ=Asia/Jakarta date)</code>%0A"
builddate=$(TZ=Asia/Jakarta date +'%H%M-%d%m%y')
START=$(date +"%s")
export ARCH=arm64
export KBUILD_BUILD_USER=KeselekPermen69
export KBUILD_BUILD_HOST=CircleCI
# Push kernel to channel
function push() {
	ZIP=$(echo 사나*.zip)
	curl -F document=@$ZIP "https://api.telegram.org/bot$token/sendDocument" \
			-F chat_id="$chat_id" \
			-F "disable_web_page_preview=true" \
			-F "parse_mode=html" \
			-F caption="Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s)."
}

function paste() {
    curl -F document=build.log "https://api.telegram.org/bot$token/sendDocument" \
			-F chat_id="$chat_id" \
			-F "disable_web_page_preview=true" \
			-F "parse_mode=html" 
}
# Stiker if build success
function stiker() {
	curl -s -F chat_id=$chat_id -F sticker="CAACAgUAAx0CUGAGVgACHrVels7L-VFrDDRSkhF91C-xjNr_9gACGgIAAiP4CjQujWf62uWo8xgE" https://api.telegram.org/bot$token/sendSticker
	}
# Stiker if build error
function stikerr() {
	curl -s -F chat_id=$chat_id -F sticker="CAACAgUAAx0CUGAGVgACHsVemA5HUaHeZOltjdQfzEDAoAf3hwACOwIAAiP4CjQ0b-ii4MiaRxgE" https://api.telegram.org/bot$token/sendSticker
	}
# Fin Error
function finerr() {
        paste
        curl -s -X POST "https://api.telegram.org/bot$token/sendMessage" \
			-d chat_id="$chat_id" \
			-d "disable_web_page_preview=true" \
			-d "parse_mode=markdown" \
			-d text="Build throw an error(s) :("
}
make ARCH=arm64 O=out lavender-perf_defconfig && \
make -j$(nproc) O=out \
                ARCH=arm64 \
                CC=clang \
                CLANG_TRIPLE=aarch64-linux-gnu- \
                CROSS_COMPILE=aarch64-linux-gnu- \
                CROSS_COMPILE_ARM32=arm-linux-gnueabi- 2>&1| tee kernel.log
if ! [ -a $IMAGE ]; then
	finerr
	stikerr
	exit 1
fi
cp out/arch/arm64/boot/Image.gz-dtb AnyKernel/zImage
paste
cd AnyKernel
zip -r9 사나-$codename_device-${branch}-${builddate}.zip *
END=$(date +"%s")
DIFF=$(($END - $START))
push
stiker
