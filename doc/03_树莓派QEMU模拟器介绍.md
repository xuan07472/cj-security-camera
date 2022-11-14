# 树莓派QEMU模拟器介绍

|作者|将狼才鲸|
|---|---|
|创建日期|2022-11-14|

所属的Gitee源码和工程地址：[才鲸嵌入式 / 开源安防摄像机（嵌入式软件）](https://gitee.com/langcai1943/cj-security-camera)

---

## 一、树莓派QEMU模拟器介绍

1. QEMU对树莓派的支持信息详见QEMU源码中的qemu\docs\system\arm\raspi.rst
内容如下：

```shell
Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``)

QEMU provides models of the following Raspberry Pi boards:

``raspi0`` and ``raspi1ap``
  ARM1176JZF-S core, 512 MiB of RAM
``raspi2b``
  Cortex-A7 (4 cores), 1 GiB of RAM
``raspi3ap``
  Cortex-A53 (4 cores), 512 MiB of RAM
``raspi3b``
  Cortex-A53 (4 cores), 1 GiB of RAM

Implemented devices
 * ARM1176JZF-S, Cortex-A7 or Cortex-A53 CPU
 * Interrupt controller
 * DMA controller
 * Clock and reset controller (CPRMAN)
 * System Timer
 * GPIO controller
 * Serial ports (BCM2835 AUX - 16550 based - and PL011)
 * Random Number Generator (RNG)
 * Frame Buffer
 * USB host (USBH)
 * GPIO controller
 * SD/MMC host controller
 * SoC thermal sensor
 * USB2 host controller (DWC2 and MPHI)
 * MailBox controller (MBOX)
 * VideoCore firmware (property)

Missing devices
 * Peripheral SPI controller (SPI)
 * Analog to Digital Converter (ADC)
 * Pulse Width Modulation (PWM)
```

* QEMU支持的一些嵌入式设备中，树莓派支持的外设最多，甚至都支持了VideoCore firmware (property) 2D 3D显示加速和视频编解码，这和对Intel和AMD的支持差不多了；而其它的嵌入式芯片都没有支持2D显示加速、图片编解码、视频编解码。
* 因为最新的P3、P4都是64位的ARM CPU，而嵌入式一般都还只是32位的，所以我选用P2 B，博通BCM2837，ARM Cortex-A7 900M 4核32位芯片，博通VideoCore GPU模块；我需要直接魔改树莓派的底层，毕竟嵌入式需要系统移植、驱动和应用都做。

* *参考网址：*
  * [使用QEMU模拟树莓派Raspberry Pi](https://cloud.tencent.com/developer/article/1685107)

2. 树莓派自身的介绍

* *参考网址：*
  * [树莓派介绍以及FAQ](https://shumeipai.nxez.com/intro-faq)
  * [树莓派系列（一）：树莓派介绍](https://blog.csdn.net/wz_coming/article/details/115454791)
  * [谁更胜一筹？ ARM Cortex-A7与A15的较量](https://tech.hqew.com/news_1360880)
  * [树莓派 介绍](https://blog.csdn.net/weixin_34233618/article/details/85905934)
  * [树莓派的详细使用，附带完整图片教程（系统安装、远程访问、初始设置、软件下载与使用）](https://blog.csdn.net/Z_xiao_bai_/article/details/122594819)
  * [树莓派的详细使用，附带完整图片教程（系统安装、远程访问、初始设置、软件下载与使用）](https://blog.csdn.net/Z_xiao_bai_/article/details/122594819)

3. 树莓派2B主控芯片BCM2837介绍

* *参考网址：*
  * [bcm2837linux编程 OS开发爱好者福利来了：树莓派上编译C语言，顺便掌握一波硬件知识](https://blog.csdn.net/weixin_35732273/article/details/111955888)
  * [mirrors_bztsrc / raspi3-tutorial](https://gitee.com/mirrors_bztsrc/raspi3-tutorial)
  * [openEuler / raspberrypi](https://gitee.com/openeuler/raspberrypi)
  * [github.com/raspberrypi/documentation.git](https://gitee.com/jikexianfeng/documentation)
  * [documentation/ hardware / raspberrypi / bcm2835](https://gitee.com/jikexianfeng/documentation/tree/master/hardware/raspberrypi/bcm2835) 有外设地址介绍
  * [BCM2837](https://gitee.com/jikexianfeng/documentation/tree/master/hardware/raspberrypi/bcm2837)
  * [树莓派3B的地址映射问题堪称新手噩梦，我用几步给大家演示一下](https://www.163.com/dy/article/H4ORDIR30552Y9C8.html)
