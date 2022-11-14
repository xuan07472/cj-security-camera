# QEMU默认支持的所有开发板、芯片列表

|作者|日期|
|---|---|
|将狼才鲸|2021-11-12|

所属的Gitee源码和工程地址：[才鲸嵌入式 / 开源安防摄像机（嵌入式软件）](https://gitee.com/langcai1943/cj-security-camera)

## 一、QEMU相关文档  
* QEMU官方文档  
[《Welcome to QEMU’s documentation!》](https://www.qemu.org/docs/master/)  

* QEMU支持的开发板详细信息在源码的docs/system下各个文档中  
* 安装git，并 clone qemu代码，代码地址：  
[《Gitee 极速下载 / qemu》](https://gitee.com/mirrors/qemu)  
* QEMU源码中不包含任何开发板的可执行文件，需要针对不同的开发板用不同的编译工具生成可执行文件后再进行测试  
* QEMU有个缺点就是没有实现任何芯片的2D显示加速、视频编解码（芯片中显卡模块的功能），可能是CPU仿这类并行计算的硬件意义不大，应该会非常慢，反而还没有直接写显存来的快，唯一的例外就是树莓派，树莓派支持上述功能。

## 二、QEMU支持的开发板列表  

QEMU默认支持以下架构的CPU：  

```
   target-arm
   target-avr
   target-m68k
   target-mips
   target-ppc
   target-riscv
   target-rx
   target-s390x
   target-sparc
   target-sparc64
   target-i386
   target-xtensa
```

* 针对开发板的音视频编解码，显示加速暂不能模拟（要测试音视频可以将代码做成兼容跨平台的，在Linux或者Windows下直接调用硬件编解码器进行测试）。  

* 以下表格不包含Intel和AMD等通用设备或者使用很少的MCU，只包含特定厂商的某一款特定开发板：  

<center>表1 QEMU支持的一些常用开发板</center>

|开发板|芯片|架构|核心|支持的模块|未实现的模块|编译工具|厂商|行业|
|---|---|---|---|---|---|---|---|---|
|stm32vldiscovery|STM32F100RBT6|arm|Cortex-M3|* ARM Cortex-M3, Cortex M4F<br/> * Analog to Digital Converter (ADC)<br/> * EXTI interrupt<br/> * Serial ports (USART)<br/> * SPI controller<br/> * System configuration (SYSCFG)<br/> * Timer controller (TIMER)|* Camera interface (DCMI)<br/> * Controller Area Network (CAN)<br/> * Cycle Redundancy Check (CRC) calculation unit<br/> * Digital to Analog Converter (DAC)<br/> * DMA controller<br/> * Ethernet controller<br/> * Flash Interface Unit<br/> * GPIO controller<br/> * I2C controller<br/> * Inter-Integrated Sound (I2S) controller<br/> * Power supply configuration (PWR)<br/> * Random Number Generator (RNG)<br/> * Real-Time Clock (RTC) controller<br/> * Reset and Clock Controller (RCC)<br/> * Secure Digital Input/Output (SDIO) interface<br/> * USB OTG<br/> * Watchdog controller (IWDG, WWDG)|Atollic TrueSTUDIO|ST|实验用的小板|
|netduino2|STM32F205RFT6|arm|Cortex-M3|同上|同上|vs2019 + Micro .net Framework SDK + Netduino SDK + **C#语言编程**|ST|类似Arduino|
|netduinoplus2|STM32F405RGT6|arm|Cortex-M4F|同上|同上|同上|ST|同上|
|imx25-pdk|i.MX25|arm|ARM926|- SD controller<br/>- AVIC<br/>- CCM<br/>- GPT<br/>- EPIT timers<br/>- FEC<br/>- RNGC<br/>- I2C<br/>- GPIO controllers<br/>- Watchdog timer<br/>- USB controllers|/|IAR Embedded Workbench for Arm—C/C++ compiler & debugger tools|NXP|消费类和工业类|
|Xilinx Versal Virt|虚拟设备|arm|Cortex-A72 * 2|- Interrupt controller (ARM GICv3)<br/>- 2 UARTs (ARM PL011)<br/>- An RTC (Versal built-in)<br/>- 2 GEMs (Cadence MACB Ethernet MACs)<br/>- 8 ADMA (Xilinx zDMA) channels<br/>- 2 SD Controllers<br/>- OCM (256KB of On Chip Memory)<br/>- XRAM (4MB of on chip Accelerator RAM)<br/>- DDR memory|does not yet model any other devices, including the PL and the AI Engine.|Linux + 交叉编译gcc，或者vivado|Xilinx|ARM+FPGA|
|Cubietech Cubieboard|全志A10|arm|Cortex-A8|- Timer<br/>- UART<br/>- RTC<br/>- EMAC<br/>- SDHCI<br/>- USB controller<br/>- SATA controller|/|sun-java6-jdk，安卓|Cubietech 和全志科技|类似树莓派|
|Orange Pi PC|全志H3|arm|Cortex-A7 * 4|* SMP (Quad Core Cortex-A7)<br/> * Generic Interrupt Controller configuration<br/> * SRAM mappings<br/> * SDRAM controller<br/> * Real Time Clock<br/> * Timer device (re-used from Allwinner A10)<br/> * UART<br/> * SD/MMC storage controller<br/> * EMAC ethernet<br/> * USB 2.0 interfaces<br/> * Clock Control Unit<br/> * System Control module<br/> * Security Identifier device|- Graphical output via HDMI, GPU and/or the Display Engine<br/>- Audio output<br/>- Hardware Watchdog|Linux + 交叉编译gcc|全志科技|类似树莓派|
|Palm Tungsten_E PDA|OMAP310|arm|ARM925T|-  Texas Instruments OMAP310 System-on-chip (ARM925T core)<br/>-  ROM and RAM memories (ROM firmware image can be loaded with<br/>   -option-rom)<br/>-  On-chip **LCD controller**<br/>-  On-chip Real Time Clock<br/>-  TI TSC2102i **touchscreen controller** / analog-digital converter /<br/>   **Audio CODEC,** connected through MicroWire and I2S busses<br/>-  GPIO-connected matrix keypad<br/>-  Secure Digital card connected to OMAP MMC/SD host<br/>-  Three on-chip UARTs||/|TI|电纸书 PDA，带显示和音频解码|
|Raspberry Pi boards|raspi0 raspi1ap raspi2b raspi3ap raspi3b|arm|ARM1176JZF-S Cortex-A7 Cortex-A53|* ARM1176JZF-S, Cortex-A7 or Cortex-A53 CPU<br/> * Interrupt controller<br/> * DMA controller<br/> * Clock and reset controller (CPRMAN)<br/> * System Timer<br/> * GPIO controller<br/> * Serial ports (BCM2835 AUX - 16550 based - and PL011)<br/> * Random Number Generator (RNG)<br/> * Frame Buffer<br/> * USB host (USBH)<br/> * GPIO controller<br/> * SD/MMC host controller<br/> * SoC thermal sensor<br/> * USB2 host controller (DWC2 and MPHI)<br/> * MailBox controller (MBOX)<br/> * VideoCore firmware (property)|* Peripheral SPI controller (SPI)<br/> * Analog to Digital Converter (ADC)<br/> * Pulse Width Modulation (PWM)|/|树莓派|微型电脑|
|Arm Realview boards|realview-eb realview-eb-mpcore realview-pb-a8 realview-pbx-a9|arm|/|-  ARM926E, ARM1136, ARM11MPCore, Cortex-A8 or Cortex-A9 MPCore CPU<br/><br/>-  Arm AMBA Generic/Distributed Interrupt Controller<br/><br/>-  Four PL011 UARTs<br/><br/>-  SMC 91c111 or SMSC LAN9118 Ethernet adapter<br/><br/>-  **PL110 LCD controller**<br/><br/>-  PL050 KMI with PS/2 **keyboard and mouse**<br/><br/>-  PCI host bridge<br/><br/>-  PCI OHCI USB controller<br/><br/>-  LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM<br/>   devices<br/><br/>-  PL181 MultiMedia Card Interface with SD card.|/| RealView MDK，Linux                                          |ARM|arm官方开发板|
|Boundary Devices SABRE Lite|i.MX6|arm|/|* Up to 4 Cortex-A9 cores<br/> * Generic Interrupt Controller<br/> * 1 Clock Controller Module<br/> * 1 System Reset Controller<br/> * 5 UARTs<br/> * 2 EPIC timers<br/> * 1 GPT timer<br/> * 2 Watchdog timers<br/> * 1 FEC Ethernet controller<br/> * 3 I2C controllers<br/> * 7 GPIO controllers<br/> * 4 SDHC storage controllers<br/> * 4 USB 2.0 host controllers<br/> * 5 ECSPI controllers<br/> * 1 SST 25VF016B flash|/|Linux|NXP, 飞思卡尔|/|
|Siemens SX1|OMAP310|arm|ARM925T|-  Texas Instruments OMAP310 System-on-chip (ARM925T core)<br/><br/>-  ROM and RAM memories (ROM firmware image can be loaded with<br/>   -pflash) V1 1 Flash of 16MB and 1 Flash of 8MB V2 1 Flash of 32MB<br/><br/>-  **On-chip LCD controller**<br/><br/>-  On-chip Real Time Clock<br/><br/>-  Secure Digital card connected to OMAP MMC/SD host<br/><br/>-  Three on-chip UARTs|/|/|TI|/|
||||||||||

* 还有大概一半的设备，因为芯片不常用或者和嵌入式无关，我就没有列出来了，感兴趣的直接去qemu源码docs/system/目录中的文档进行翻阅  

* qemu的仿真主循环位于cpu-exec.c:cpu_exec函数中  

* *参考网址：*
  * [qemu源码分析](https://www.cnblogs.com/long123king/p/3584053.html)  
  * [【系列分享】QEMU内存虚拟化源码分析](https://www.anquanke.com/post/id/86412)  
  * [QEMU源码分析系列(二)](http://blog.chinaunix.net/uid-8679615-id-5710883.html)  

## 三、所有的开发板或CPU核详细介绍的英文摘抄

* 原始文档在qemu源码docs/system/目录中

```
   target-arm
   target-avr
   target-m68k
   target-mips
   target-ppc
   target-riscv
   target-rx
   target-s390x
   target-sparc
   target-sparc64
   target-i386
   target-xtensa
```

### MIPS芯片

* QEMU supports variety of MIPS CPU models:

Supported CPU models for MIPS32 hosts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The following CPU models are supported for use on MIPS32 hosts.
Administrators / applications are recommended to use the CPU model that
matches the generation of the host CPUs in use. In a deployment with a
mixture of host CPU models between machines, if live migration
compatibility is required, use the newest CPU model that is compatible
across all desired hosts.

``mips32r6-generic``
    MIPS32 Processor (Release 6, 2015)
    

``P5600``
    MIPS32 Processor (P5600, 2014)

``M14K``, ``M14Kc``
    MIPS32 Processor (M14K, 2009)

``74Kf``
    MIPS32 Processor (74K, 2007)

``34Kf``
    MIPS32 Processor (34K, 2006)

``24Kc``, ``24KEc``, ``24Kf``
    MIPS32 Processor (24K, 2003)

``4Kc``, ``4Km``, ``4KEcR1``, ``4KEmR1``, ``4KEc``, ``4KEm``
    MIPS32 Processor (4K, 1999)


Supported CPU models for MIPS64 hosts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


``I6400``
    MIPS64 Processor (Release 6, 2014)

``Loongson-2E``
    MIPS64 Processor (Loongson 2, 2006)

``Loongson-2F``
    MIPS64 Processor (Loongson 2, 2008)

``Loongson-3A1000``
    MIPS64 Processor (Loongson 3, 2010)

``Loongson-3A4000``
    MIPS64 Processor (Loongson 3, 2018)

``mips64dspr2``
    MIPS64 Processor (Release 2, 2006)

``MIPS64R2-generic``, ``5KEc``, ``5KEf``
    MIPS64 Processor (Release 2, 2002)

``20Kc``
    MIPS64 Processor (20K, 2000

``5Kc``, ``5Kf``
    MIPS64 Processor (5K, 1999)

``VR5432``
    MIPS64 Processor (VR, 1998)

``R4000``
    MIPS64 Processor (MIPS III, 1991)


Supported CPU models for nanoMIPS hosts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``I7200``
    MIPS I7200 (nanoMIPS, 2018)

Preferred CPU models for MIPS hosts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


The following CPU models are preferred for use on different MIPS hosts:

``MIPS III``
    R4000

``MIPS32R2``
    34Kf

``MIPS64R6``
    I6400

``nanoMIPS``
    I7200

### X86 AMD

``EPYC``, ``EPYC-IBPB``
    AMD EPYC Processor (2017)

``Opteron_G5``
    AMD Opteron 63xx class CPU (2012)

``Opteron_G4``
    AMD Opteron 62xx class CPU (2011)

``Opteron_G3``
    AMD Opteron 23xx (Gen 3 Class Opteron, 2009)

``Opteron_G2``
    AMD Opteron 22xx (Gen 2 Class Opteron, 2006)

``Opteron_G1``
    AMD Opteron 240 (Gen 1 Class Opteron, 2004)


Important CPU features for AMD x86 hosts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ### Xtensa处理器
 -  Xtensa emulator pseudo board \"sim\"

-  Avnet LX60/LX110/LX200 board
-  A range of Xtensa CPUs, default is the DC232B

-  Console and filesystem access via semihosting calls

The Avnet LX60/LX110/LX200 emulation supports:

-  A range of Xtensa CPUs, default is the DC232B

-  16550 UART

-  OpenCores 10/100 Mbps Ethernet MAC

### sparc64处理器
-  UltraSparc IIi APB PCI Bridge

-  PCI VGA compatible card with VESA Bochs Extensions

-  PS/2 mouse and keyboard

-  Non Volatile RAM M48T59

-  PC-compatible serial ports

-  2 PCI IDE interfaces with hard disk and CD-ROM support

-  Floppy disk

### sparc处理器

-  SPARCstation 4

-  SPARCstation 5

-  SPARCstation 10

-  SPARCstation 20

-  SPARCserver 600MP

-  SPARCstation LX

-  SPARCstation Voyager

-  SPARCclassic

-  SPARCbook

QEMU emulates the following sun4m peripherals:

-  IOMMU

-  TCX or cgthree Frame buffer

-  Lance (Am7990) Ethernet

-  Non Volatile RAM M48T02/M48T08

-  Slave I/O: timers, interrupt controllers, Zilog serial ports,
   keyboard and power/reset logic

-  ESP SCSI controller with hard disk and CD-ROM support

-  Floppy drive (not on SS-600MP)

-  CS4231 sound device (only on SS-5, not working yet)

### s390x
.. toctree::
   s390x/vfio-ap
   s390x/css
   s390x/3270
   s390x/vfio-ccw

Architectural features

.. toctree::
   s390x/bootdevices
   s390x/protvirt

### rx芯片

-  R5F562N8 MCU

   -  On-chip memory (ROM 512KB, RAM 96KB)
   -  Interrupt Control Unit (ICUa)
   -  8Bit Timer x 1CH (TMR0,1)
   -  Compare Match Timer x 2CH (CMT0,1)
   -  Serial Communication Interface x 1CH (SCI0)

-  External memory 16MByte

### riscv

.. toctree::
   :maxdepth: 1

   riscv/microchip-icicle-kit
   riscv/shakti-c
   riscv/sifive_u
   riscv/virt

RISC-V CPU firmware

### ppc
.. toctree::
   :maxdepth: 1

   ppc/embedded
   ppc/powermac
   ppc/powernv
   ppc/ppce500
   ppc/prep
   ppc/pseries

### mips

-  A range of MIPS CPUs, default is the 24Kf

-  PC style serial port

-  PC style IDE disk

-  NE2000 network card

The Malta emulation supports the following devices:

-  Core board with MIPS 24Kf CPU and Galileo system controller

-  PIIX4 PCI/USB/SMbus controller

-  The Multi-I/O chip's serial device

-  PCI network cards (PCnet32 and others)

-  Malta FPGA serial device

-  Cirrus (default) or any other PCI VGA graphics card

The Boston board emulation supports the following devices:

-  Xilinx FPGA, which includes a PCIe root port and an UART

-  Intel EG20T PCH connects the I/O peripherals, but only the SATA bus
   is emulated

The ACER Pica emulation supports:

-  MIPS R4000 CPU

-  PC-style IRQ and DMA controllers

-  PC Keyboard

-  IDE controller

The MIPS Magnum R4000 emulation supports:

-  MIPS R4000 CPU

-  PC-style IRQ controller

-  PC Keyboard

-  SCSI controller

-  G364 framebuffer

The Fuloong 2E emulation supports:

-  Loongson 2E CPU

-  Bonito64 system controller as North Bridge

-  VT82C686 chipset as South Bridge

-  RTL8139D as a network card chipset

The Loongson-3 virtual platform emulation supports:

-  Loongson 3A CPU

-  LIOINTC as interrupt controller

-  GPEX and virtio as peripheral devices

-  Both KVM and TCG supported

-  A range of MIPS CPUs, default is the 24Kf

-  PC style serial port

-  MIPSnet network emulation

-  nanoMIPS I7200 CPU

### m68k
The M5208EVB emulation includes the following devices:

-  MCF5208 ColdFire V2 Microprocessor (ISA A+ with EMAC).

-  Three Two on-chip UARTs.

-  Fast Ethernet Controller (FEC)

The AN5206 emulation includes the following devices:

-  MCF5206 ColdFire V2 Microprocessor.

-  Two on-chip UARTs.

### AVR

- Continuous non interrupted execution::

   qemu-system-avr -machine mega2560 -bios demo.elf

### ARM

.. toctree::
   :maxdepth: 1

   arm/integratorcp
   arm/mps2
   arm/musca
   arm/realview
   arm/sbsa
   arm/versatile
   arm/vexpress
   arm/aspeed
   arm/sabrelite
   arm/digic
   arm/cubieboard
   arm/emcraft-sf2
   arm/highbank
   arm/musicpal
   arm/gumstix
   arm/mainstone
   arm/kzm
   arm/nrf
   arm/nseries
   arm/nuvoton
   arm/imx25-pdk
   arm/orangepi
   arm/palm
   arm/raspi
   arm/xscale
   arm/collie
   arm/sx1
   arm/stellaris
   arm/stm32
   arm/virt
   arm/xlnx-versal-virt

#### xscale 有音频编解码

The Sharp Zaurus are PDAs based on XScale, able to run Linux ('SL series').

The SL-6000 (\"Tosa\"), released in 2005, uses a PXA255 System-on-chip.

The SL-C3000 (\"Spitz\"), SL-C1000 (\"Akita\"), SL-C3100 (\"Borzoi\") and
SL-C3200 (\"Terrier\") use a PXA270.

The clamshell PDA models emulation includes the following peripherals:

-  Intel PXA255/PXA270 System-on-chip (ARMv5TE core)

-  NAND Flash memory - not in \"Tosa\"

-  IBM/Hitachi DSCM microdrive in a PXA PCMCIA slot - not in \"Akita\"

-  On-chip OHCI USB controller - not in \"Tosa\"

-  On-chip LCD controller

-  On-chip Real Time Clock

-  TI ADS7846 touchscreen controller on SSP bus

-  Maxim MAX1111 analog-digital converter on |I2C| bus

-  GPIO-connected keyboard controller and LEDs

-  Secure Digital card connected to PXA MMC/SD host

-  Three on-chip UARTs

-  WM8750 audio CODEC on |I2C| and |I2S| busses

#### Xilinx 有双核
Implemented CPU cores:

- 2 ACPUs (ARM Cortex-A72)

Implemented devices:

- Interrupt controller (ARM GICv3)
- 2 UARTs (ARM PL011)
- An RTC (Versal built-in)
- 2 GEMs (Cadence MACB Ethernet MACs)
- 8 ADMA (Xilinx zDMA) channels
- 2 SD Controllers
- OCM (256KB of On Chip Memory)
- XRAM (4MB of on chip Accelerator RAM)
- DDR memory

#### virt 只是一个虚拟的板子，不对应任何实际硬件

The virt board supports:

- PCI/PCIe devices
- Flash memory
- One PL011 UART
- An RTC
- The fw_cfg device that allows a guest to obtain data from QEMU
- A PL061 GPIO controller
- An optional SMMUv3 IOMMU
- hotpluggable DIMMs
- hotpluggable NVDIMMs
- An MSI controller (GICv2M or ITS). GICv2M is selected by default along
  with GICv2. ITS is selected by default with GICv3 (>= virt-2.7). Note
  that ITS is not modeled in TCG mode.
- 32 virtio-mmio transport devices
- running guests using the KVM accelerator on aarch64 hardware
- large amounts of RAM (at least 255GB, and more if using highmem)
- many CPUs (up to 512 if using a GICv3 and highmem)
- Secure-World-only devices if the CPU has TrustZone:

  - A second PL011 UART
  - A second PL061 GPIO controller, with GPIO lines for triggering
    a system reset or system poweroff
  - A secure flash memory
  - 16MB of secure RAM

Supported guest CPU types:

- ``cortex-a7`` (32-bit)
- ``cortex-a15`` (32-bit; the default)
- ``cortex-a53`` (64-bit)
- ``cortex-a57`` (64-bit)
- ``cortex-a72`` (64-bit)
- ``a64fx`` (64-bit)
- ``host`` (with KVM only)
- ``max`` (same as ``host`` for KVM; best possible emulation with TCG)

#### vexpress，有显示控制，（但没有2D加速，图片编解码，视频编解码）

Implemented devices:

- PL041 audio
- PL181 SD controller
- PL050 keyboard and mouse
- PL011 UARTs
- SP804 timers
- I2C controller
- PL031 RTC
- PL111 LCD display controller
- Flash memory
- LAN9118 ethernet

Unimplemented devices:

- SP810 system control block
- PCI-express
- USB controller (Philips ISP1761)
- Local DAP ROM
- CoreSight interfaces
- PL301 AXI interconnect
- SCC
- System counter
- HDLCD controller (``vexpress-a15``)
- SP805 watchdog
- PL341 dynamic memory controller
- DMA330 DMA controller
- PL354 static memory controller
- BP147 TrustZone Protection Controller
- TrustZone Address Space Controller

#### versatile 有显示驱动

-  ARM926E, ARM1136 or Cortex-A8 CPU

-  PL190 Vectored Interrupt Controller

-  Four PL011 UARTs

-  SMC 91c111 Ethernet adapter

-  PL110 LCD controller

-  PL050 KMI with PS/2 keyboard and mouse.

-  PCI host bridge. Note the emulated PCI bridge only provides access
   to PCI memory space. It does not provide access to PCI IO space. This
   means some devices (eg. ne2k_pci NIC) are not usable, and others (eg.
   rtl8139 NIC) are only usable when the guest drivers use the memory
   mapped control registers.

-  PCI OHCI USB controller.

-  LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM
   devices.

-  PL181 MultiMedia Card Interface with SD card.

#### sx1 有OMAP310，有显示控制


-  Texas Instruments OMAP310 System-on-chip (ARM925T core)

-  ROM and RAM memories (ROM firmware image can be loaded with
   -pflash) V1 1 Flash of 16MB and 1 Flash of 8MB V2 1 Flash of 32MB

-  On-chip LCD controller

-  On-chip Real Time Clock

-  Secure Digital card connected to OMAP MMC/SD host

-  Three on-chip UARTs

#### stm32


The STM32F1 series is based on ARM Cortex-M3 core. The following machines are
based on this chip :

- ``stm32vldiscovery``  STM32VLDISCOVERY board with STM32F100RBT6 microcontroller

The STM32F2 series is based on ARM Cortex-M3 core. The following machines are
based on this chip :

- ``netduino2``         Netduino 2 board with STM32F205RFT6 microcontroller

The STM32F4 series is based on ARM Cortex-M4F core. This series is pin-to-pin
compatible with STM32F2 series. The following machines are based on this chip :

- ``netduinoplus2``     Netduino Plus 2 board with STM32F405RGT6 microcontroller


Supported devices

 * ARM Cortex-M3, Cortex M4F
 * Analog to Digital Converter (ADC)
 * EXTI interrupt
 * Serial ports (USART)
 * SPI controller
 * System configuration (SYSCFG)
 * Timer controller (TIMER)

Missing devices

 * Camera interface (DCMI)
 * Controller Area Network (CAN)
 * Cycle Redundancy Check (CRC) calculation unit
 * Digital to Analog Converter (DAC)
 * DMA controller
 * Ethernet controller
 * Flash Interface Unit
 * GPIO controller
 * I2C controller
 * Inter-Integrated Sound (I2S) controller
 * Power supply configuration (PWR)
 * Random Number Generator (RNG)
 * Real-Time Clock (RTC) controller
 * Reset and Clock Controller (RCC)
 * Secure Digital Input/Output (SDIO) interface
 * USB OTG
 * Watchdog controller (IWDG, WWDG)

#### stellaris 有小显示屏
-  Cortex-M3 CPU core.

-  64k Flash and 8k SRAM.

-  Timers, UARTs, ADC and |I2C| interface.

-  OSRAM Pictiva 96x16 OLED with SSD0303 controller on
   |I2C| bus.

The Luminary Micro Stellaris LM3S6965EVB emulation includes the
following devices:

-  Cortex-M3 CPU core.

-  256k Flash and 64k SRAM.

-  Timers, UARTs, ADC, |I2C| and SSI interfaces.

-  OSRAM Pictiva 128x64 OLED with SSD0323 controller connected via
   SSI.
   
#### sbsa 有显示

The sbsa-ref board supports:

  - A configurable number of AArch64 CPUs
  - GIC version 3
  - System bus AHCI controller
  - System bus EHCI controller
  - CDROM and hard disc on AHCI bus
  - E1000E ethernet card on PCIe bus
  - VGA display adaptor on PCIe bus
  - A generic SBSA watchdog device

#### sabrelite 多核

 * Up to 4 Cortex-A9 cores
 * Generic Interrupt Controller
 * 1 Clock Controller Module
 * 1 System Reset Controller
 * 5 UARTs
 * 2 EPIC timers
 * 1 GPT timer
 * 2 Watchdog timers
 * 1 FEC Ethernet controller
 * 3 I2C controllers
 * 7 GPIO controllers
 * 4 SDHC storage controllers
 * 4 USB 2.0 host controllers
 * 5 ECSPI controllers
 * 1 SST 25VF016B flash

#### realview 显示，键盘鼠标

The following devices are emulated:

-  ARM926E, ARM1136, ARM11MPCore, Cortex-A8 or Cortex-A9 MPCore CPU

-  Arm AMBA Generic/Distributed Interrupt Controller

-  Four PL011 UARTs

-  SMC 91c111 or SMSC LAN9118 Ethernet adapter

-  PL110 LCD controller

-  PL050 KMI with PS/2 keyboard and mouse

-  PCI host bridge

-  PCI OHCI USB controller

-  LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM
   devices

-  PL181 MultiMedia Card Interface with SD card.

#### raspi 树莓派，显示，2D 3D显示加速、视频编解码（博通GPU）

QEMU provides models of the following Raspberry Pi boards:

``raspi0`` and ``raspi1ap``
  ARM1176JZF-S core, 512 MiB of RAM
``raspi2b``
  Cortex-A7 (4 cores), 1 GiB of RAM
``raspi3ap``
  Cortex-A53 (4 cores), 512 MiB of RAM
``raspi3b``
  Cortex-A53 (4 cores), 1 GiB of RAM


Implemented devices 已实现的设备

 * ARM1176JZF-S, Cortex-A7 or Cortex-A53 CPU
 * Interrupt controller
 * DMA controller
 * Clock and reset controller (CPRMAN)
 * System Timer
 * GPIO controller
 * Serial ports (BCM2835 AUX - 16550 based - and PL011)
 * Random Number Generator (RNG)
 * Frame Buffer 液晶显示
 * USB host (USBH)
 * GPIO controller
 * SD/MMC host controller
 * SoC thermal sensor
 * USB2 host controller (DWC2 and MPHI)
 * MailBox controller (MBOX)
 * VideoCore firmware (property) 视频编解码


#### palm，OMAP310，显示，触摸屏，音频编解码

-  Texas Instruments OMAP310 System-on-chip (ARM925T core)

-  ROM and RAM memories (ROM firmware image can be loaded with
   -option-rom)

-  On-chip LCD controller

-  On-chip Real Time Clock

-  TI TSC2102i touchscreen controller / analog-digital converter /
   Audio CODEC, connected through MicroWire and |I2S| busses

-  GPIO-connected matrix keypad

-  Secure Digital card connected to OMAP MMC/SD host

-  Three on-chip UARTs

#### orangepi，橙派

The Orange Pi PC machine supports the following devices:

 * SMP (Quad Core Cortex-A7)
 * Generic Interrupt Controller configuration
 * SRAM mappings
 * SDRAM controller
 * Real Time Clock
 * Timer device (re-used from Allwinner A10)
 * UART
 * SD/MMC storage controller
 * EMAC ethernet
 * USB 2.0 interfaces
 * Clock Control Unit
 * System Control module
 * Security Identifier device

#### nuvoton

- ``npcm750-evb``       Nuvoton NPCM750 Evaluation board

The NPCM730 SoC has two Cortex-A9 cores and is targeted for Data Center and
Hyperscale applications. The following machines are based on this chip :

- ``quanta-gbs-bmc``    Quanta GBS server BMC
- ``quanta-gsj``        Quanta GSJ server BMC
- ``kudo-bmc``          Fii USA Kudo server BMC

There are also two more SoCs, NPCM710 and NPCM705, which are single-core
variants of NPCM750 and NPCM730, respectively. These are currently not
supported by QEMU.

Supported devices

 * SMP (Dual Core Cortex-A9)
 * Cortex-A9MPCore built-in peripherals: SCU, GIC, Global Timer, Private Timer
   and Watchdog.
 * SRAM, ROM and DRAM mappings
 * System Global Control Registers (GCR)
 * Clock and reset controller (CLK)
 * Timer controller (TIM)
 * Serial ports (16550-based)
 * DDR4 memory controller (dummy interface indicating memory training is done)
 * OTP controllers (no protection features)
 * Flash Interface Unit (FIU; no protection features)
 * Random Number Generator (RNG)
 * USB host (USBH)
 * GPIO controller
 * Analog to Digital Converter (ADC)
 * Pulse Width Modulation (PWM)
 * SMBus controller (SMBF)
 * Ethernet controller (EMC)
 * Tachometer

#### nseries，OMAP2420，显示，触摸屏，

-  Texas Instruments OMAP2420 System-on-chip (ARM1136 core)

-  RAM and non-volatile OneNAND Flash memories

-  Display connected to EPSON remote framebuffer chip and OMAP on-chip
   display controller and a LS041y3 MIPI DBI-C controller

-  TI TSC2301 (in N800) and TI TSC2005 (in N810) touchscreen
   controllers driven through SPI bus

-  National Semiconductor LM8323-controlled qwerty keyboard driven
   through |I2C| bus

-  Secure Digital card connected to OMAP MMC/SD host

-  Three OMAP on-chip UARTs and on-chip STI debugging console

-  Mentor Graphics \"Inventra\" dual-role USB controller embedded in a
   TI TUSB6010 chip - only USB host mode is supported

-  TI TMP105 temperature sensor driven through |I2C| bus

-  TI TWL92230C power management companion with an RTC on
   |I2C| bus

-  Nokia RETU and TAHVO multi-purpose chips with an RTC, connected
   through CBUS

#### nrf

Supported devices

 * ARM Cortex-M0 (ARMv6-M)
 * Serial ports (UART)
 * Clock controller
 * Timers
 * Random Number Generator (RNG)
 * GPIO controller
 * NVMC
 * SWI

#### musicpal，音频编解码，小屏幕显示


-  Marvell MV88W8618 Arm core.

-  32 MB RAM, 256 KB SRAM, 8 MB flash.

-  Up to 2 16550 UARTs

-  MV88W8xx8 Ethernet controller

-  MV88W8618 audio controller, WM8750 CODEC and mixer

-  128x64 display with brightness control

-  2 buttons, 2 navigation wheels with button function

#### mps2

``mps2-an385``
  Cortex-M3 as documented in Arm Application Note AN385
``mps2-an386``
  Cortex-M4 as documented in Arm Application Note AN386
``mps2-an500``
  Cortex-M7 as documented in Arm Application Note AN500
``mps2-an505``
  Cortex-M33 as documented in Arm Application Note AN505
``mps2-an511``
  Cortex-M3 'DesignStart' as documented in Arm Application Note AN511
``mps2-an521``
  Dual Cortex-M33 as documented in Arm Application Note AN521
``mps3-an524``
  Dual Cortex-M33 on an MPS3, as documented in Arm Application Note AN524
``mps3-an547``
  Cortex-M55 on an MPS3, as documented in Arm Application Note AN547

Differences between QEMU and real hardware:

- AN385/AN386 remapping of low 16K of memory to either ZBT SSRAM1 or to
  block RAM is unimplemented (QEMU always maps this to ZBT SSRAM1, as
  if zbt_boot_ctrl is always zero)
- AN524 remapping of low memory to either BRAM or to QSPI flash is
  unimplemented (QEMU always maps this to BRAM, ignoring the
  SCC CFG_REG0 memory-remap bit)
- QEMU provides a LAN9118 ethernet rather than LAN9220; the only guest
  visible difference is that the LAN9118 doesn't support checksum
  offloading
- QEMU does not model the QSPI flash in MPS3 boards as real QSPI
  flash, but only as simple ROM, so attempting to rewrite the flash
  from the guest will fail
- QEMU does not model the USB controller in MPS3 boards

#### mainstone 有显示，有声音输出
 which uses a PXA270 CPU.

Emulated devices:

- Flash memory
- Keypad
- MMC controller
- 91C111 ethernet
- PIC
- Timer
- DMA
- GPIO
- FIR
- Serial
- LCD controller
- SSP
- USB controller
- RTC
- PCMCIA
- I2C
- I2S

#### kzm
Emulated devices:

- UARTs
- LAN9118 ethernet
- AVIC
- CCM
- GPT
- EPIT timers
- I2C
- GPIO controllers
- Watchdog timer

#### integratorcp 显示
The Arm Integrator/CP board is emulated with the following devices:

-  ARM926E, ARM1026E, ARM946E, ARM1136 or Cortex-A8 CPU

-  Two PL011 UARTs

-  SMC 91c111 Ethernet adapter

-  PL110 LCD controller

-  PL050 KMI with PS/2 keyboard and mouse.

-  PL181 MultiMedia Card Interface with SD card.

#### imx25-pdk

Emulated devices:

- SD controller
- AVIC
- CCM
- GPT
- EPIT timers
- FEC
- RNGC
- I2C
- GPIO controllers
- Watchdog timer
- USB controllers

#### highbank

Emulated devices:

- L2x0 cache controller
- SP804 dual timer
- PL011 UART
- PL061 GPIOs
- PL031 RTC
- PL022 synchronous serial port controller
- AHCI
- XGMAC ethernet controllers

#### gumstix，显示，音频

Implemented devices:

 * NOR flash
 * SMC91C111 ethernet
 * Interrupt controller
 * DMA
 * Timer
 * GPIO
 * MMC/SD card
 * Fast infra-red communications port (FIR)
 * LCD controller
 * Synchronous serial ports (SPI)
 * PCMCIA interface
 * I2C
 * I2S

#### emcraft-sf2
- System timer
- System registers
- SPI controller
- UART
- EMAC

#### cubieboard 全志

Emulated devices:

- Timer
- UART
- RTC
- EMAC
- SDHCI
- USB controller
- SATA controller

#### collie
 * NOR flash
 * Interrupt controller
 * Timer
 * RTC
 * GPIO
 * Peripheral Pin Controller (PPC)
 * UARTs
 * Synchronous Serial Ports (SSP)

#### aspeed

AST2400 SoC based machines :

- ``palmetto-bmc``         OpenPOWER Palmetto POWER8 BMC
- ``quanta-q71l-bmc``      OpenBMC Quanta BMC

AST2500 SoC based machines :

- ``ast2500-evb``          Aspeed AST2500 Evaluation board
- ``romulus-bmc``          OpenPOWER Romulus POWER9 BMC
- ``witherspoon-bmc``      OpenPOWER Witherspoon POWER9 BMC
- ``sonorapass-bmc``       OCP SonoraPass BMC
- ``swift-bmc``            OpenPOWER Swift BMC POWER9

AST2600 SoC based machines :

- ``ast2600-evb``          Aspeed AST2600 Evaluation board (Cortex-A7)
- ``tacoma-bmc``           OpenPOWER Witherspoon POWER9 AST2600 BMC

Supported devices

 * SMP (for the AST2600 Cortex-A7)
 * Interrupt Controller (VIC)
 * Timer Controller
 * RTC Controller
 * I2C Controller
 * System Control Unit (SCU)
 * SRAM mapping
 * X-DMA Controller (basic interface)
 * Static Memory Controller (SMC or FMC) - Only SPI Flash support
 * SPI Memory Controller
 * USB 2.0 Controller
 * SD/MMC storage controllers
 * SDRAM controller (dummy interface for basic settings and training)
 * Watchdog Controller
 * GPIO Controller (Master only)
 * UART
 * Ethernet controllers
 * Front LEDs (PCA9552 on I2C bus)
 * LPC Peripheral Controller (a subset of subdevices are supported)
 * Hash/Crypto Engine (HACE) - Hash support only. TODO: HMAC and RSA
