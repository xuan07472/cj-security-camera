# 嵌入式开源项目-CJ安防摄像机 裸机项目介绍

|作者|将狼才鲸|
|---|---|
|创建日期|2022-11-19|

* Gitee源码和工程地址：[才鲸嵌入式 / 开源安防摄像机（嵌入式软件）](https://gitee.com/langcai1943/cj-security-camera)
* CSDN文章地址：[项目介绍：开源安防摄像机（嵌入式软件）](https://blog.csdn.net/qq582880551/article/details/127857259)

---

## 一、项目介绍

* 这是BCM2836的裸机仓库，文件结构和源码模仿Linux，借鉴于Linux kernel的linux_6.1-rc4发布版本。
  * Linux阅读与下载地址：[Linux 6.1-rc4](https://gitee.com/mirrors/linux_old1/tree/v6.1-rc4)
* 树莓派1的ARM程序名为kernel.img（默认为ARMv6架构），树莓派2为kernel7.img（含义为ARMv7架构），树莓派3为kernel8.img（含义为ARMv8架构）。
* 具体BCM2836硬件相关的代码参考于[dwelch67/raspberrypi](https://github.com/dwelch67/raspberrypi)

```shell
jim@DESKTOP-SVP3BEM MINGW64 /d/1_git/dwelch67-raspberrypi/raspberrypi (master)
$ tree -L 1
.
|-- README		// 自述文件，描述了树莓派的启动流程、支持的树莓派版本，没有介绍每个文件夹的作用
|-- armjtag		// 描述要用jtag必须要做的硬件改动，使用什么仿真器，怎么使用仿真器
|-- atags		// 和bootloader05中内容类似，演示运行kernel.img时操作r0~r2寄存器，树莓派1串口打印
|-- baremetal	// 汇编LED灯和串口操作，大量汇编编程技巧的描述
|-- bench02		// 树莓派1指令集测试，外面的都是树莓派1的用例，树莓派2和3都在boards文件夹中
|-- blinker01	// 树莓派1汇编用GPIO点亮LCD
|-- blinker02	// 树莓派1定时器
|-- blinker03	// 树莓派1使用ARM定时器
|-- blinker04	// 树莓派1ARM定时器
|-- blinker05	// 树莓派1中断处理
|-- blinker06	// 树莓派1看门狗
|-- blinker07	// 树莓派1定时器中断
|-- blinker08	// 树莓派1使用FIQ代替IRQ
|-- boards		// 树莓派2和树莓派3的一众用例
|   |-- cpuid	// 通过查看CPU ID确定是树莓派的哪个版本的硬件
|   |-- pi1
|   |-- pi2
|   |   |-- HYP	// ARM处于HYP超级监视者模式，级别比SVC低
|   |   |   |-- blinker01	// 树莓派2用GPIO点亮LED灯
|   |   |   |-- blinker02
|   |   |   |-- blinker03
|   |   |   |-- blinker04
|   |   |   |-- blinker05
|   |   |   `-- blinker06
|   |   |-- SVC	// ARM处于9种模式之一的SVC超级管理员模式
|   |   |   |-- blinker01
|   |   |   |-- blinker02
|   |   |   |-- blinker03
|   |   |   |-- blinker04
|   |   |   `-- blinker05
|   |   |-- SVC_BOOT
|   |   |   |-- uart01		// 树莓派2串口操作
|   |   |   `-- uart02
|   |   `-- bootloader07	// 树莓派2用串口引导程序运行，引导16进制程序，
|   |-- pi3
|   |   |-- aarch32
|   |   `-- aarch64
|   |-- piaplus
|   |-- pibplus
|   `-- pizero
|-- bootloader01	// 树莓派1用串口引导程序
|-- bootloader02	// 同上
|-- bootloader03	// 同上，使用bin文件
|-- bootloader04	// 同上，使用配置文件
|-- bootloader05	// 同上
|-- bootloader06	// 同上
|-- bootloader07	// 同上
|-- bssdata		// 树莓派1使用.bss、.data和.text，有详细解说
|-- extest		// 树莓派1使用MMU虚拟地址
|-- float02		// 树莓派1浮点数处理
|-- float03		// 树莓派1更多的浮点型处理
|-- gps_clock	// 树莓派1GPS模块
|-- jtagproxy	// 树莓派1使用JTAG
|-- mmu			// 树莓派1 MMU虚拟地址
|-- multi00		// 树莓派1 ARM和GPU双核通信
|-- newlib0		// 树莓派1 使用newlib库
|-- spi01		// 树莓派1 操作SPI屏幕
|-- spi02		// 同上
|-- spi03		// 同上
|-- tas			// 树莓派1使用tas编译工具
|-- twain		// 树莓派1不同的编译器？
|-- uart01		// 树莓派1串口操作
|-- uart02		// 同上
|-- uart03		// 同上
|-- uart04		// 同上
|-- uart05		// 同上
|-- uartx01		// 同上
|-- video01		// 树莓派1用视频帧缓冲区在屏幕上输出内容
|-- zero_start	// 树莓派1零地址相关的内容
`-- zlib

45 directories, 1 file
```

* 大量测试用例的工程都在samples文件夹中

## 二、测试用例介绍

|用例名|作用|备注|
|---|---|---|
|01_asm_boot|汇编boot||

## 三、测试用例详解

### 1）01_asm_boot

* 汇编boot程序，引导C语言main函数执行；跳转到main之前要配置堆栈。
* vector.s是整个ARM程序的入口，就像其它的8051或者ARM boot程序一样；这是CPU上电后复位中断执行的第一行代码所在处。
* 该模块工程所在的目录为：cj-security-camera\src\samples\01_asm_boot
* 该模块内源码参考自：https://gitee.com/mirrors_dwelch67/raspberrypi/tree/master/boards/pi2/SVC_BOOT/uart01 ，或者https://github.com/dwelch67/raspberrypi/tree/master/boards/pi2/SVC_BOOT/uart01


