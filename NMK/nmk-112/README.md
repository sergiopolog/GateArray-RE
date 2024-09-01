# NMK-112

NEC CMOS-4(?) gate array. Model 65006 in a QFP64 package

OKI M6295 ROM Banking chip used in many NMK arcade game PCBs (*also in DonPachi and Power Instinct*)

It supports up to 2 OKIs.

Provides 8 of 6-bit registers, 4 of them used to store 4 different Bank values for each OKI.
The actual bank value used each time is selected by `OKI_A8-9` address bits when addressing ROM sample table (`OKI_A10-17 == 0`), or by `OKI_A16-17` bits otherwise.

SVG file could be overlapped on die image from: [https://siliconpr0n.org/archive/doku.php?id=furrtek:nmk:112](https://siliconpr0n.org/archive/doku.php?id=furrtek:nmk:112)


Huge thanks to:
* [@furrtek](https://github.com/furrtek) for decapping and imaging the silicon die
* [Caius](https://x.com/caiusarcade) for donating the chip