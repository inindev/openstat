## Building OpenWRT

#### Ensure Build Prerequisites are Installed
```
sudo apt install bc flex bison libncurses-dev gawk

git clone https://github.com/inindev/openstat.git
```

#### Download, Patch, and Compile
```
git clone https://github.com/openwrt/openwrt.git
cd openwrt

git fetch --tags
git tag

git checkout openwrt-19.07
make distclean

./scripts/feeds update -a
./scripts/feeds install -a

git am ../openstat/linux/openwrt/0001-at91bootstrap-target-for-resideo-rth9580wf01-board.patch
git am ../openstat/linux/openwrt/0002-u-boot-target-for-resideo-rth9580wf01-board.patch
git am ../openstat/linux/openwrt/0003-support-for-resideo-rth9580wf01-board.patch
git am ../openstat/linux/openwrt/0004-resideo-rth9580wf01-thermostat-device-tree.patch

cp ../openstat/linux/openwrt/defconfig .config
make defconfig

make download
make -j$(($(nproc)+1))
```

#### Output
```
Once the openwrt build successfully completes, the targets of the build will be
located in the bin/targets/at91/sam9x directory.

spl: bin/targets/at91/sam9x/at91bootstrap-rth9580wf01_uboot/at91bootstrap.bin
u-boot: bin/targets/at91/sam9x/u-boot-rth9580wf01_spiflash/u-boot.bin
kernel: bin/targets/at91/sam9x/openwrt-at91-sam9x-rth9580wf01-uImage
rootfs: bin/targets/at91/sam9x/openwrt-at91-sam9x-rth9580wf01-squashfs-rootfs.bin

The complete firmware suitable for flashing on the 16MB SPI NOR Flash:
  bin/targets/at91/sam9x/openwrt-at91-sam9x-rth9580wf01-firmware.bin
```
