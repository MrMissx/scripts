# /usr/bin/env python3
# get the android bootanimation trim.txt value
# output will like WxH+X+Y
#
# https://android.googlesource.com/platform/frameworks/base/+/master/cmds/bootanimation/FORMAT.md#trim_txt

import time
import sys


def resomid(reso):
    try:
        a, b = reso.split("x", 1)
        print(f"\nWidth={a} , Height={b}\n")
        w = int(a) / 2
        h = int(b) / 2
        return w, h
    except ValueError as e:
        print(f"\nuhmmm... we got an error {e}")
        sys.exit()


def pictmid(width, height):
    midx = width / 2
    midy = height / 2
    return midx, midy


def compile(w, h, midx, midy):
    x = w - midx
    y = h - midy
    output = (f"{rwidth}x{rheight}+{int(x)}+{int(y)}")
    return output


# Resolution of the bootanimation WidthxHeight
reso = input("Enter the bootanimation resolution(eg: 1080x2280 ): ")
while "x" not in reso:
    print("\nmake sure you input the resolution corectly (don't forget the \"x\")")
    reso = input("Enter here: ")

get_mid1, get_mid2 = resomid(reso)
time.sleep(0.5)

# input the Croped picture WidthxHeight
rwidth = int(input("Enter the picture width(pixel): "))
time.sleep(0.5)
rheight = int(input("Enter the picture height(pixel): "))
time.sleep(1)

# start operation
getpic_mid1, getpic_mid2 = pictmid(rwidth, rheight)
final = compile(get_mid1, get_mid2, getpic_mid1, getpic_mid2)

print("\nhere your trim.txt vaule")
print(f"-> {final}")
