# Building the Firmware

The current iteration of this project is based upon the [RTH9580WF01](https://apps.fcc.gov/oetcf/eas/reports/ViewExhibitReport.cfm?mode=Exhibits&calledFromFrame=N&application_id=iot1OeLFV0f%2Fi%2Bsbj98nGQ%3D%3D&) hardware. This device runs a 400MHz [Atmel SAM9G35](https://www.microchip.com/wwwproducts/en/AT91SAM9G35) ARM based Microcontroller with 16MB ISSI [IS42/45S16800F](https://www.issi.com/WW/pdf/42-45S81600F-16800F.pdf) RAM and 16MB ISSI [IS25LP128](https://www.issi.com/WW/pdf/25LP-WP128F.pdf) NOR Flash.

The current firmware consists of three components: spl, u-boot, and linux (openwrt)

### spl
The Secondary Program Loader (spl) gets executed by the ROM of the microcontroller and is responsible for low-level setup of the hardware on the board, such as timing of the SDR SDRAM. The spl used in this implementation is [at91bootstrap](https://www.linux4sam.org/bin/view/Linux4SAM/AT91Bootstrap).
<br/>_--> Note that this step is no longer necessary as the spl build has been integrated into the openwrt build below._
<br/><s>[building spl](boot/at91bootstrap/readme.md)</s>

### u-boot
The final stage of bootstrapping is accomplished using [u-boot](https://www.denx.de/wiki/U-Boot).
<br/>_--> Note that this step is no longer necessary as u-boot has been integrated into the openwrt build below._
<br/><s>[building u-boot](boot/u-boot/readme.md)</s>

### linux
The linux distribution currently being used for this project is [openwrt](https://openwrt.org). Note that this step now builds the spl, u-boot, and openwrt.
<br/>[building openwrt linux](linux/openwrt/readme.md)
