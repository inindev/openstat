# Building the Firmware

The current iteration of this project is based upon the [RTH9580WF01](https://apps.fcc.gov/oetcf/eas/reports/ViewExhibitReport.cfm?mode=Exhibits&calledFromFrame=N&application_id=iot1OeLFV0f%2Fi%2Bsbj98nGQ%3D%3D&) hardware. This device runs a 400MHz [Atmel SAM9G35](https://www.microchip.com/wwwproducts/en/AT91SAM9G35) ARM based Microcontroller with 16MB ISSI [IS42/45S16800F](https://www.issi.com/WW/pdf/42-45S81600F-16800F.pdf) RAM and 16MB ISSI [IS25LP128](https://www.issi.com/WW/pdf/25LP-WP128F.pdf) NOR Flash.

The current firmware consists of three components: spl, u-boot, and linux (openwrt)

### spl
The Secondary Program Loader (spl) gets executed by the ROM of the microcontroller and is responsible for low-level setup of the hardware on the board, such as timing of the SDR SDRAM. The spl used in this implementation is [at91bootstrap](https://www.linux4sam.org/bin/view/Linux4SAM/AT91Bootstrap).
<br/>[building spl](boot/at91bootstrap/readme.md)

### u-boot
The final stage of bootstrapping is accomplished using [u-boot](https://www.denx.de/wiki/U-Boot).
<br/>[building u-boot](boot/u-boot/readme.md)

### linux
The linux distribution currently being used for this project is [openwrt](https://openwrt.org).
<br/>[building openwrt linux](linux/openwrt/readme.md)

_Note that while openwrt has outstanding support for cross-compiling, both at91bootstrap and u-boot require a cross compiler if not built on a 32 bit ARM device (such as a raspberry pi). These instructions currently assume a 32 bit ARM build using a debian based linux._
