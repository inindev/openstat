## Building the Secondary Program Loader (spl)

#### Ensure Build Prerequisites are Installed
```
sudo apt install bc flex bison libncurses-dev gawk

git clone https://github.com/inindev/openstat.git
```

#### Download, Patch, and Compile
```
git clone https://github.com/linux4sam/at91bootstrap.git
cd at91bootstrap
git checkout at91bootstrap-3.x

git am ../openstat/boot/at91bootstrap/0001-Winbond-SPI-Flash-support.patch
  Applying: Winbond SPI Flash support

git am ../openstat/boot/at91bootstrap/0002-ISSI-SPI-Flash-support.patch
  Applying: ISSI SPI Flash support

git am ../openstat/boot/at91bootstrap/0003-16MB-RAM-Option.patch
  Applying: 16MB RAM Option

git am ../openstat/boot/at91bootstrap/0004-board-files-for-resideo-rth9580wf01-thermostat.patch
  Applying: board files for resideo rth9580wf01 thermostat

make rth9580wf01_uboot_defconfig
make
```
