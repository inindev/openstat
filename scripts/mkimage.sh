#!/bin/sh
#
# Copyright 2021 The OpenStat Authors
#
# This file is part of OpenStat.
#
# OpenStat is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# OpenStat is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with OpenStat.  If not, see <https://www.gnu.org/licenses/>.
#
# Author: John Clark (inindev@gmail.com)
#

script=$(readlink -f "$0")
project=$(dirname "$(dirname "$script")")
base=$(dirname "$project")

output="./firmware.bin"


add_paritions() {
    entry '16m'  'erase'   "$output"

    entry '32k'  'spl'     "$base/at91bootstrap/binaries/at91bootstrap.bin"
    entry '16k'  'uenv1'   '# uboot environment 1'
    entry '16k'  'uenv2'   '# uboot environment 2'
    entry '704k' 'uboot'   "$base/u-boot/u-boot.bin"
    entry '4m'   'kernel'  "$base/openwrt/bin/targets/at91/sam9x/openwrt-at91-sam9x-rth9580wf01-uImage"
    entry '4m'   'rootfs'  "$base/openwrt/bin/targets/at91/sam9x/openwrt-at91-sam9x-rth9580wf01-squashfs-rootfs.bin"
    entry '-'    'data'    '# data'
}

entry() {
    local slen="$1"
    local type="$2"
    local src="$3"
    local bs=512  # dd block size

    local blen=$(parse_num $slen)

    if [ "$type" = "erase" ]; then
        tot=$blen
        num=0
        ptr=0
        rm -rf "$output"
        printf "${RED}erasing %s flash: %s${NC}\n" $slen, "$output"
        dd bs=$bs if=/dev/zero count=$((blen/bs)) | tr '\000' '\377' > "$output"
        printf "\n${CYA}#   size   utl   start   end    file path & date${NC}\n"
	return
    fi

    echo "$src" | grep -q '^#.*'
    if [ $? -eq 0 ]; then  # comment
        if [ "$slen" = "-" ]; then
            type="$type ($(echo "scale=2; $blen/1048576" | bc -l)m)"
        fi
        printf "%d) ${GRN}%6s  (0%%)  ${ORN}%06x-%06x  ${VIO}%s${NC}\n" $num "($slen)" $ptr $((ptr+blen-1)) "# $type"
    else
        local fname=$(basename "$src")
        local fsize=$(stat -c%s "$src")
        local pct=$(((fsize*100)/blen))
        local mod="$(date +'%m/%d/%Y %T %Z' -d @$(stat -c %Y $src))"
        printf "%d) ${GRN}%6s %5s  ${ORN}%06x-%06x  ${VIO}%s  ${GRN}(%s)${NC}\n" $num "($slen)" "($pct%)" $ptr $((ptr+blen-1)) "$fname" "$mod"
        dd bs=$bs if="$src" of="$output" seek=$((ptr/bs)) conv=notrunc 2> /dev/null
    fi

    num=$((num + 1))
    ptr=$((ptr + blen))
}

parse_num() {
    local val="$1"
    if [ "$val" = "-" ]; then
        printf "%d" $((tot - ptr))  # remaining space
    else
        local res=$(($(echo $val | sed -e 's/k/<<10/' -e 's/m/<<20/')))
        printf "%d" $res
    fi
}

main() {
    local tot=0
    local num=0
    local ptr=0
    add_paritions
}


RED='\033[0;31m'
GRN='\033[0;32m'
ORN='\033[0;33m'
BLU='\033[0;34m'
VIO='\033[0;35m'
CYA='\033[0;36m'
NC='\033[0m'
#echo "${RED}RED\n${GRN}GRN\n${ORN}ORN\n${BLU}BLU\n${VIO}VIO\n${CYA}CYA\n${NC}"

main
