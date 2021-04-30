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
