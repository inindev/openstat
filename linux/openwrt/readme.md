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
git checkout v19.07.7 -b v19.07.7
make distclean

./scripts/feeds update -a
./scripts/feeds install -a

git am ../openstat/linux/openwrt/0001-support-for-resideo-rth9580wf01-board.patch
cp ../openstat/linux/openwrt/diffconfig .config

make defconfig
make
```
