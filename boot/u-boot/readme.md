## Building u-boot

#### Ensure Build Prerequisites are Installed
```
sudo apt install bc flex bison libncurses-dev gawk

git clone https://github.com/inindev/openstat.git
```

#### Download, Patch, and Compile
```
git clone https://github.com/u-boot/u-boot.git
cd u-boot

git fetch --tags
git checkout v2021.04 -b v2021.04

git am ../openstat/boot/u-boot/0001-board-files-for-resideo-rth9580wf01-thermostat.patch
  Applying: board files for resideo rth9580wf01 thermostat

git am ../openstat/boot/u-boot/0002-device-tree-for-resideo-rth9580wf01-thermostat.patch
  Applying: device tree for resideo rth9580wf01 thermostat

make rth9580wf01_spiflash_defconfig
make
```
