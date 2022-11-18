# 项目介绍：嵌入式开源项目-CJ安防摄像机

|作者|将狼才鲸|
|---|---|
|创建日期|2022-11-14|

* Gitee源码和工程地址：[才鲸嵌入式 / 开源安防摄像机（嵌入式软件）](https://gitee.com/langcai1943/cj-security-camera)
* CSDN文章地址：[项目介绍：开源安防摄像机（嵌入式软件）](https://blog.csdn.net/qq582880551/article/details/127857259)
* *注：文章中的子文档链接需在Gitee中的readme.md仓库介绍中才能点开，我设置的是相对地址，也可以在Gitee仓库的doc文件夹下手动点开。*

---

* 简介：使用ARM Cortex-A7 32位内核、带有GPU（2D 3D显示加速、图片和音频视频编解码）的博通BCM2836芯片（树莓派2B同款硬件，但不使用树莓派的系统和软件），在QEMU模拟器中运行，实现安防摄像机、音视频播放器等嵌入式设备的功能。

<center>表1 本仓库软硬件资源描述</center>

|**软硬件资源**|详情|备注|
|---|---|---|
|QEMU BCM2836芯片模拟器|900MHz 4核 ARM Cortex-A7 CPU, VideoCore IV 双核 GPU (2D 3D显示加速, 视频编解码), 1GB 内存, 100M以太网, HDMI显示, USB2.0 x 4, SD卡, 音频输出, GPIO, 摄像头输入, 液晶屏接口, 串口, SPI, I2C等嵌入式通用模块|树莓派2B同款硬件|
|**硬件模块测试用例：raspi3-tutorial**|裸机程序，包含让CPU运行的空程序、串口打印、屏幕图像输出、屏幕文字输出、读写SD卡、bootloader|在仓库根目录raspi3-tutorial文件夹中, 开箱即用, 直接make, 直接在QEMU中运行|
|**裸机工程**|......未开始......||
|**RTOS工程**|......未开始......||
|**Linux工程**|......未开始......||
|**使用的开源库**|||

---

## 一、前言

1. 作为一名嵌入式软件工程师，我想自己从头开始做一个实际的嵌入式产品；结合自己工作中接触过的技术，我决定做一个带有通信、GUI、音视频编码、音视频解码功能的设备，思来想去选定了安防摄像机领域。

2. 创建这个仓库的目的，一是记录自己学习到的技术，防止时间久了忘记；二是给其他也想要做一个实际嵌入式项目的人一个参考，最好是能开箱即用，能看到产品的效果，然后能方便的阅读源码和注释，知晓原理，而不用自己去一步步搭建环境；搭环境是很痛苦的，往往遇到一个问题跨不过去，又没人指导，然后就不得不放弃了。

3. 我不使用具体的开发板，而是使用QEMU模拟器；原因一就是上面“第2条前言”所描述的通用和开箱即用，因为不同的开发板太多了，开发板也很贵，真的没必要让看这个工程的人还去花钱买块板子，板子买回来很大的概率也是吃灰。原因二是我自己也从来没买过开发板，也不喜欢在开发板上频繁下载调试程序，很慢也很烦，一般纯逻辑的模块我会先用gcc或者模拟器验证好，然后再上板子调试。原因三是芯片原厂开发芯片开发包时，芯片还没设计好的初期也会先使用模拟器，不过他们完整的模拟器代码并没有流传出来而已。

4. 在硬件选型的过程中，其实我最中意的是瑞芯微的芯片，但无奈他们家的产品在QEMU模拟器中并不支持；然后我查看了QEMU支持的所有嵌入式芯片，发现除了树莓派、Intel、AMD，其它的芯片都不支持其中的显示加速、音视频编解码，有些芯片仅仅只支持了不加速的液晶屏显示、触摸屏、音频解码，还有些芯片只支持了串口、GPIO、SPI、I2C等基础的外设。所以没有选择，只有树莓派。

5. 但树莓派也不是最完美的选项，最新的几款树莓派芯片都是64位的ARM，只能选用32位CPU的老版本；而且树莓派所使用的博通芯片的手册还是不公开的，能找到的资料也少，这对嵌入式开发很不利，但还好基本的外设寄存器地址还是能找到的，网上也能找到一些底层开发的教程；我刚毕业时也用过博通BCM2042和BCM20730蓝牙芯片，对博通也不是两眼一抹黑；尽管困难重重，但也要慢慢解决问题。

6. 其它带有GPU的MCU芯片还有RK3399、RV1126、RK3588、RK3288、Exynos4412、DM6446等；全志的资料不公开，和博通一样，只面向大客户公开资料，所以也放弃使用全志芯片；海思的芯片也没找到模拟器，也就不用了。

7. 一些带2D显示加速和音视频编解码模块的嵌入式开发板信息：
  * [RV1126/RV1109芯片 人工智能安防开发板介绍](https://blog.csdn.net/weixin_52411576/article/details/114986087)
  * [CORTEX-A9三星iTOP-4412开发开发板入门嵌入式](https://blog.csdn.net/mucheni/article/details/125204333)
  * [RK3399开发板](https://blog.csdn.net/Chihiro_S/article/details/105368415)
  * [IMX6UL开发板 mjpg-streamer 移植实现远程监控](https://blog.csdn.net/Chihiro_S/article/details/119753233)
  * [迅为RK3588开发板Linux安卓12瑞芯微ARM核心板人工智能工业AI主板](https://blog.csdn.net/mucheni/article/details/126267513)
  * [安卓开发板 MTK 方案 ARM 主板定制](https://blog.csdn.net/yangyang__z/article/details/126404411)
  * [海思Hi3518EV200+4G+RS232视频监控摄像开发板防雷防静电推荐图](https://blog.csdn.net/shanghaileimao/article/details/116229998)
  * [DM6446数字视频开发板](https://blog.csdn.net/weixin_33694172/article/details/93359406)
  * [andoird TV 优化学习笔记](https://blog.csdn.net/qw85525006/article/details/103220708) 

## 二、QEMU模拟器介绍

* QEMU是一个硬件模拟器和仿真器，和VMware类似，能安装和运行Windows和Linux，但除此之外它还可以模拟众多的嵌入式芯片和开发板，从ARM Cortex-M3到Cortex-Axx内核都支持。
* 你把QEMU当成一个开发板就行，编好了程序后，可以下到QEMU里面去运行。
* 同样能模拟嵌入式硬件的还有Keil，Keil debug时选中Simulator即可。
  * Keil模拟器的使用，详见我其它的两个仓库：
  * [才鲸嵌入式 / 8051_c51_单片机从汇编到C_从Boot到应用实践教程](https://gitee.com/langcai1943/8051-from-boot-to-application)
  * [才鲸嵌入式 / ARM-Cortex-M3从汇编到C_从Boot到应用教程](https://gitee.com/langcai1943/ARM-Cortex-M3_from-assembly-to-c)
* QEMU的详细介绍详见本仓库**子文档**：
  * [《01_QEMU仿真器-模拟器介绍.md》](./doc/01_QEMU仿真器-模拟器介绍.md)
  * [《02_QEMU默认支持的所有开发板列表.md》](./doc/02_QEMU默认支持的所有开发板列表.md)

## 三、树莓派介绍

* 树莓派本质上是一个计算机，所以提供了完整的操作系统和应用软件，但是它的老款芯片是32位的ARM，也可以用于嵌入式领域。
* 树莓派的详细介绍详见本仓库**子文档**：[《03_树莓派QEMU模拟器介绍.md》](./doc/03_树莓派QEMU模拟器介绍.md)

## 四、必须的准备工作

* 本章前面的总述和前面3小节只是对要做的工作进行一个文字描述，本章第4小节有完整的安装过程，可以直接跳到”4）完整的环境安装步骤“进行阅读。

1. 首先，需要Linux或者Windows MinGW等环境，如果你是第一次使用Linux，则不应该摸索Windows下的MinGW环境，这应该是对Linux已经很熟悉之后才做的事，因为在里面装软件很麻烦；你应该直接使用Ubuntu或其它Linux发行板，推荐在Windows下使用VMware虚拟机安装Ubuntu；具体的过程略。

2. Ubuntu下安装QEMU，这也等同于准备好了一块硬件开发板，过程略。

3. Ubuntu下安装ARM交叉编译工具，过程略。

4. 编译程序，运行程序。

* 如果你以前用过树莓派，那么请忘掉它，我们按照嵌入式的模式来。

* 写树莓派的底层程序，并不能像8051或普通MCU芯片一样，使用汇编，从零地址开始的复位中断开始写，能够控制芯片上电后执行的第一条指令；因为树莓派上电后是芯片里面的GPU先开始运行，并且这部分代码是不公开的，GPU底层的寄存器介绍也是不公开的，只能加载官方提供的GPU的驱动；GPU上电后再引导ARM CPU运行。
* 但其实如果不是在芯片原厂，一般嵌入式开发人员也不需要知道芯片开发包里面的boot是如何实现的，编译器里面的C标准库是如何实现的，中断向量表和堆栈是如何分配的，各个驱动模板是如何实现的，操作系统是怎么移植的；能用就行。

### 1）安装Linux环境

* 可以在Windows下安装MSYS2，或者安装Cygwin，这都是Linux运行环境；如果安装了Git，里面也会自带精简版的MSYS2+MinGW64；如果你有已经安装过MSYS2环境的朋友，特别是他已经安装好了树莓派交叉编译工具和其它工具，你可以将他安装过的文件夹拷过来，在你的电脑上也同样可以点开即用，换句话说就是安装过一次以后的MSYS2是绿色软件，只是文件比较大，会有几十G。
* 也可以先安装VMware Player虚拟机，然后在虚拟机中安装Ubuntu系统，这是一个Linux发行版；直接使用Linux系统，安装软件的教程和各种资料会比MingW更方便；如果你有已经在虚拟机中安装过Linux的朋友，特别是他在已经安装好了树莓派交叉编译工具、QEMU和其它工具，你可以将他安装过的系统文件夹拷贝过来。
* 还可以使用双系统，或者干脆准备一台装了Linux的电脑。

### 2）用QEMU模拟器运行树莓派

* QEMU可以在Windows下安装，也可以在Linux下安装。

* *参考网址：*
  * [QEMU仿真树莓派1和3B-保姆级教程](https://zhuanlan.zhihu.com/p/452590356)
  * [使用QEMU模拟树莓派](http://t.zoukankan.com/HacTF-p-7773671.html)
  * [使用QEMU模拟树莓派Raspberry Pi](https://cloud.tencent.com/developer/article/1685107)
  * [QEMU 模拟启动 openEuler 的树莓派镜像](https://blog.csdn.net/hhs_1996/article/details/123153534)

### 3）编译树莓派程序

* 树莓派交叉编译工具可以在Windows下安装，也可以在Linux下安装。

* *参考网址：*
  * [树莓派基础之交叉编译](https://blog.csdn.net/weixin_55374007/article/details/126697371)
  * [Windows下建立第一个树莓派应用程序-交叉编译](https://blog.csdn.net/yhhdll0107/article/details/123571694)
  * [树莓派（六）树莓派交叉编译](https://blog.csdn.net/weixin_50546241/article/details/126339437)
  * [Windows下建立第一个树莓派应用程序-交叉编译](https://blog.csdn.net/yhhdll0107/article/details/123571694)
  * [在window上如何搭建树莓派4b的RT-Thread开发环境](https://www.yisu.com/zixun/528265.html)
  * [在Windows下使用C语言开始Raspberry Pi Pico开发](https://www.lexsion.com/index.php/archives/199/)

### 4）完整的环境安装步骤

* 写在前面，我会提供已经安装好各种工具的MSYS2环境，如果你没用过Linux，建议你直接下载本系统压缩包cj_msys64.zip，解压后使用，或者自行使用VMware Player虚拟机+Ubuntu安装开发环境，因为MSYS2中安装软件的教程很难快速找到，需要有一些使用Linux的经验才知道怎么安装特定软件；我的MSYS2环境添加了32位和64位的交叉编译工具，他们的来源不一样，后面会详述。

* 下面是从头到尾的工具软件安装步骤：
  * 推荐使用MSYS2 + 已经用MinGW32或MinGW64编译好的程序，基本上开发过程中你能在Linux下实现的，也都能在这个环境下实现，只是有些教程没有Ubuntu下那么好找；在MSYS2中不能使用Linux的程序，必须用MinGW将源码重新编译过后才能使用，这一般是软件供应商已经做好的。
  * MSYS2的更多信息详见本仓库**子文档**：[《04_MSYS2简述.md》](./doc/04_MSYS2简述.md)

<center>表2 MSYS2、MinGW和Cygwin的关系</center>

|软件名|版本|作用|特点|
|---|---|---|---|
|MSYS|MSYS，MSYS2|Linux命令行终端：Shell，Bash|没有在Windows下编译Linux程序的工具集，会自带已经被MinGW编译好的一些包；脱胎于Cygwin，但容量更小；MSYS2是因为MSYS常年不更新而新组的的一个项目；MSYS2安装完后的文件名为msys64，你可以将你安装好之后的msys64文件夹打包发给别人，这样别人无安装就可以用了，只是容量有点大，几十G|
|MinGW|MinGW32，MinGW64|一组编译工具链|编译后生成的是纯粹的Windows程序；它自带的命令行终端很难用也不全，要和MSYS2终端配合使用；MinGW64是因为MinGW32常年不更新而新组的的一个项目|
|Cygwin|Cygwin|编译工具+命令行|有模拟层，将Linux API转成Windows API再执行程序，效率低，容量大，速度慢，2010年左右在Windows下搭建交叉编译环境时还多用它；要运行纯粹的Linux程序时也用它|

* *参考网址：*
  * [CygWin、MingW、MSYS之间的关系](https://www.jianshu.com/p/09198f6e0a3c)
  * [Cygwin、Msys、MinGW、Msys2的区别与联系(转)](https://blog.csdn.net/u012294613/article/details/126460773)
  * [Cygwin、MinGw、mingw-w64,MSys msys2区别与联系](https://www.cnblogs.com/zengkefu/p/7371943.html)
  * [MSYS2+MinGW32 编译 QEMU需做的准备工作](https://blog.csdn.net/mozart_cai/article/details/79680685)
  * [在Windows上编译QEMU](https://blog.csdn.net/weixin_34062329/article/details/91654482)

#### 4.1 安装MSYS2

1. 我当前下载的版本是msys2-x86_64-20221028.exe
  * 网上的安装教程是[使用msys2打造优雅的开发环境](https://www.cnblogs.com/52fhy/p/15158765.html)
  * 在官网主页找到下载链接：[github.com/msys2/msys2-installer/releases/download/2022-10-28/msys2-x86_64-20221028.exe](https://github.com/msys2/msys2-installer/releases/download/2022-10-28/msys2-x86_64-20221028.exe) ，85M左右，这只是一个安装器，不是全部的软件；这是GitHub的地址，有时候下载慢，有时候无法访问；这个可下载的软件是CICD自动生成的，国内的Gitee镜像中也没有这个下载包；但你也可以在网上其它的地方比如网盘之类的找到这个文件的下载。
2. 我将软件安装在D盘根目录，软件会安装在d:\msys64中，安装目录不能有空格、中文。
3. 安装完之后先不打开软件，先将国外镜像地址换成国内镜像地址，参考上方教程。
4. 电脑配置环境变量，在PATH中增加一行D:\msys64\usr\bin
  * [win10环境变量怎么设置 win10设置环境变量的方法](https://www.win7zhijia.cn/win10jc/win10_47252.html)
5. 双击运行主目录下的msys2.exe或者mingw64.exe都可以，其它的exe有些是32位的，有些是非gcc编译器对应的软件。

#### 4.2 MSYS2中安装QEMU

* 因为我已经有了MSYS2环境，可以在里面直接安装QEMU；你下载Windows版本的QEMU单独安装，也是走的MSYS2+MinGW这一套，只是和Git一样，它们都是在自己的软件安装包自带了精简版的MinGW环境。

* 我们不需要用MinGW64或者MinGW32编译QEMU，我们只安装已经编译好的QEMU软件；网上没搜到MSYS2中安装QEMU的教程，但是我们知道MSYS2中的所有软件都在[packages.msys2.org/repos](https://packages.msys2.org/repos) 、 [MSYS2 Base Packages](https://packages.msys2.org/base) 和 [MSYS2 Packages](https://packages.msys2.org/package)中有描述。
* 在https://packages.msys2.org/base 中能找到mingw-w64-qemu；在https://packages.msys2.org/package/ 中能找到mingw-w64-x86_64-qemu；在https://packages.msys2.org/package/mingw-w64-x86_64-qemu?repo=mingw64 中能找到/mingw64/bin/qemu-system-aarch64.exe、/mingw64/bin/qemu-system-arm.exe，也能找到安装方法：pacman -S mingw-w64-x86_64-qemu；我当前使用的是Build Date: 2022-10-10 20:19:53，Installed Size: 768.72 MB，实际安装完后有2G。
* 查看是否安装成功：进入cd /mingw64/bin/ 然后./qemu-system-arm.exe --version查看版本号；后续还需要设置环境变量，这里暂略。
* 能看到输出信息：

```shell
jim@DESKTOP-SVP3BEM MSYS /mingw64/bin
$ ./qemu-system-arm.exe --version
QEMU emulator version 7.1.0
Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers
```

#### 4.3 MSYS2中安装32位和64位ARM交叉编译工具

* 一些工具介绍：
  * 树莓派提供了在Linux下使用的交叉工具包的文件夹名为gcc-linaro-arm-linux-gnueabihf-raspbian-x64，使用的编译器名为arm-linux-gnueabihf-gcc，下载地址[raspberrypi-tools/ arm-bcm2708](https://gitee.com/qianchenzhumeng/raspberrypi-tools/tree/master/arm-bcm2708)。
  * GNU官方提供了树莓派在Windows中使用的交叉工具包，默认的工具是使用Visual Studio +  VisualGDB来进行编译的。  
  32位地址：[Prebuilt Windows Toolchain for Raspberry Pi](https://gnutoolchains.com/raspberry/)  
  64位地址：[Prebuilt Windows Toolchain for Raspberry Pi (64-bit)](https://gnutoolchains.com/raspberry64/)  
  * ARM在Windows下自带的交叉编译工具为gcc-arm-none-eabi-10.3-2021.10-win32.exe，网页路径在https://developer.arm.com/downloads/-/gnu-rm ，交叉编译工具名为arm-none-eabi-gcc，我们不使用树莓派自带的交叉编译工具，而直接使用ARM的；因为树莓派没有直接给出MinGW下的交叉编译工具，而我也不想在Cygwin环境使用树莓派的Linux交叉编译工具。

* 但也不在ARM官方下载，我们在MSYS2中同样也能找到：在https://packages.msys2.org/base 中能搜到mingw-w64-arm-none-eabi-gcc和mingw-w64-arm-none-eabi-gdb
  * MSYS2下载命令 pacman -S mingw-w64-x86_64-arm-none-eabi-gcc，大小有1.24 GB，参考网址：[Package: mingw-w64-x86_64-arm-none-eabi-gcc](https://packages.msys2.org/package/mingw-w64-x86_64-arm-none-eabi-gcc?repo=mingw64)
  * GDB调试工具下载的命令 pacman -S mingw-w64-x86_64-arm-none-eabi-gdb，大小有7.92 MB，参考网址：[Package: mingw-w64-x86_64-arm-none-eabi-gdb](https://packages.msys2.org/package/mingw-w64-x86_64-arm-none-eabi-gdb?repo=mingw64)
  * 安装完成后的文件在msys64/mingw64/bin/arm-none-eabi-gcc.exe
  * 如果你需要使用aarch64-elf-gcc编译64位的ARM程序，在新版的树莓派中运行，则MSYS2网站中没有，你要去Linaro软件中下载。
* 如果有需要，你也可以安装用于64位ARM的交叉编译工具。
  * 软件名称：[gcc-linaro-7.5.0-2019.12-i686-mingw32_aarch64-linux-gnu.tar.xz](https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-7.5.0-2019.12-i686-mingw32_aarch64-linux-gnu.tar.xz) ，大小364M
  * 下载路径：https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/
  * 下载完之后放到msys64/mingw32/bin/里面去，用Linux命令解压，然后设置环境变量，使用方法和32位gcc交叉编译工具一样
  * 我msys64中的路径是msys64/mingw32/bin/gcc-linaro-7.5.0-2019.12-i686-mingw32_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc.exe
  * 在Linaro这里也能下到32位的GCC交叉编译工具：[gcc-linaro-7.5.0-2019.12-i686-mingw32_arm-linux-gnueabihf.tar.xz](https://releases.linaro.org/components/toolchain/binaries/latest-7/arm-linux-gnueabihf/)
  * https://www.linaro.org/ Linaro公司主要是做ARM的一些开源工具，树莓派也是直接使用的Linaro编译器。

* MSYS2安装make
  * pacman -S make
  * [Package: make](https://packages.msys2.org/package/make?repo=msys&variant=x86_64)

* *参考网址：*
  * [Windows下编译树莓派pico C\C++（Building on MS Windows）](https://blog.csdn.net/m0_45961169/article/details/127282390)
  * [树莓派 交叉编译环境搭建（Win 7）](https://www.cnblogs.com/easy-busy/p/4402218.html)
  * [【交叉编译踩坑指北（二）】windows10下VScode构建树莓派pico开发环境（C/C++）](https://blog.csdn.net/SuperiorEE/article/details/127380128)
  * [树莓派2 raspyberry Pi2 交叉编译app](https://www.cnblogs.com/zhangjiankun/p/4855169.html)
  * [Windows10下 交叉编译aarch64(ARMv8)架构Qt5.12.11库](https://blog.csdn.net/y_q_m/article/details/120319055)

#### 4.4 用现成的程序从QEMU运行树莓派

* 从以下网址https://gitee.com/mirrors_bztsrc/raspi3-tutorial/tree/master/0A_pcscreenfont 下载编译好的树莓派程序，我已下载好，存放在msys64家目录下的1_raspi/01_run文件夹中
* 使用命令运行：/mingw64/bin/qemu-system-aarch64 -M raspi3b -kernel ~/1_raspi/01_run/kernel8.img -d in_asm
* 能看到出现了QEMU窗口，并显示了hello world。
效果如下：![img](./picture/01_QEMU_RUN.png)

#### 4.5 交叉编译工具编译程序，并在树莓派QEMU模拟中运行

1. 在[mirrors_bztsrc/raspi3-tutorial](https://gitee.com/mirrors_bztsrc/raspi3-tutorial)下载一个国外的英文仓库，是演示64位ARM树莓派裸机编程的，我借鉴这里面的工程。
  * 这个工程已下载到当前仓库根目录下，我也会将这个目录拷贝到msys64的家目录下，我会将里面的Makefile和自动运行改成和msys64适配，保证一个make命令就能编译程序，一个make run就能在QEMU中运行刚刚编译的程序。
  * 输出qemu所在位置和aarch64编译器所在位置的环境变量，这样就不用每次都写完整的路径了。
  * 打开家目录也就是msys64/home/jim/下的.bashrc，在里面末尾加上  
    export PATH=$PATH:/mingw64/bin  
    export PATH=$PATH:/mingw32/bin/gcc-linaro-7.5.0-2019.12-i686-mingw32_aarch64-linux-gnu/bin  
  * 生效配置 source .bashrc
  * 查看环境变量 echo $PATH，确认已经生效

2. 进入msys64 raspi3-tutorial源码目录，编译并运行
  * 源码我已经拷贝到msys64中，并且已经改了Makefile，能直接编译和运行，同时修改过以后的源码我也会在本仓重上传
  * 源码路径 ~/raspi3-tutorial/01_bareminimum，也就是/home/jim/raspi3-tutorial/01_bareminimum，也就是D:\msys64\home\jim\raspi3-tutorial\01_bareminimum，后面所有的示例路径我都采用第一种写法。
  * 进入目录 cd ~/raspi3-tutorial/01_bareminimum
  * 编译 make
  * 运行 make run
  * make run能运行，是因为在Makefile里面写了命令 qemu-system-aarch64 -M raspi3b -kernel kernel8.img -d in_asm
  * 01_bareminimum用例是一个空程序，所以QEMU里面什么都不会显示，其它用例的效果我会再后面展示。

* *参考网址：*
* 树莓派有关裸机编程的教程很少，我只找到了几个英文教程和几篇中文博客：
  * 裸机编程：[mirrors_bztsrc / raspi3-tutorial](https://gitee.com/mirrors_bztsrc/raspi3-tutorial)
  * 编写操作系统：[lxjj / rpi4-osdev](https://gitee.com/lxjj/rpi4-osdev)
  * 一点中文翻译，[在树莓派4B上编写裸机操作系统(PART0)](https://www.bilibili.com/read/cv11175486)
  * 另一个树莓派操作系统开发：[Baking Pi – Operating Systems Development](https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/os/)
  * [RPi bring up hello world! 树莓派底层编程裸机点亮led](https://zhuanlan.zhihu.com/p/519166136)
  * [996refuse/emperorOS Public](https://github.com/996refuse/emperorOS/tree/756bb64a9019cd5c3ca2fa887c3a1d76b910c86f)
  * [4 anbox 树莓派 树莓派4裸机基础教程:从hello world开始](https://blog.csdn.net/weixin_36372094/article/details/112191177)
  * [Raspberry PI 系列 —— 裸机点亮LED灯](http://t.zoukankan.com/zhchoutai-p-6970667.html)

* *参考网址：*
* [树莓派的交叉编译 （BCM2835/6/7/BCM23711）](https://www.valvers.com/open-software/raspberry-pi/bare-metal-programming-in-c-part-1/)

#### 4.6 有关树莓派裸机编程的介绍

* 树莓派里面有GPU和ARM CPU，GPU先上电运行，然后再引导ARM运行
* 树莓派的GPU底层固件（Bootloader）是闭源的，但可以在此基础上引导自己的U-Boot、Linux kernel，也可以不用U-Boot和Linux，直接引导裸机程序或者RTOS；这种引导方式和Xilinx ZYNQ类似，ARM和FPGA一个先启动一个后启动。

* 一些其它的树莓派嵌入式相关的开源仓库：
(1) 运行在 Raspberry Pi 上的小型嵌入式系统
- Xinu project ([xinu-os/xinu](https://link.zhihu.com/?target=https%3A//github.com/xinu-os/xinu))
- Ultibo project ([ultibohub/Core](https://link.zhihu.com/?target=https%3A//github.com/ultibohub/Core))

(2) 一些在 Raspberry Pi 上可以嵌入在其他系统中的运行库
- USPi([rsta2/uspi](https://link.zhihu.com/?target=https%3A//github.com/rsta2/uspi)), 一个小型的支持 USB 通讯的库

(3) 以及其他一些基于 Raspberry Pi 裸机开发例子：
- Bare Metal Programming on Raspberry Pi 3：([bztsrc/raspi3-tutorial](https://link.zhihu.com/?target=https%3A//github.com/bztsrc/raspi3-tutorial))
- Raspberry Pi ARM based bare metal examples ([dwelch67/raspberrypi](https://link.zhihu.com/?target=https%3A//github.com/dwelch67/raspberrypi))

* *参考网址：*
  * [RPi bring up hello world! 树莓派底层编程裸机点亮led](https://www.bilibili.com/read/cv17759097/)
  * [从底层玩转树莓派](https://zhuanlan.zhihu.com/p/148629587)，里面有树莓派RTOS操作系统的链接
  * [详细到吐血 —— 树莓派驱动开发入门：从读懂框架到自己写驱动](https://huaweicloud.csdn.net/63561a2ad3efff3090b5a464.html)
  * [在树莓派3b上如何运行uboot](https://www.yisu.com/zixun/528297.html)
  * [7个别出心裁的树莓派优质项目集锦（完整代码+电路设计资料）](https://www.cirmall.com/articles/27528/)
  * [树莓派BootLoader](https://blog.csdn.net/rk2900/article/details/8936580)
  * [树莓派的启动流程](https://blog.csdn.net/qq_45172832/article/details/126040945)
  * [树莓派裸板linux,树莓派裸机开发步骤](https://blog.csdn.net/weixin_35578211/article/details/116987578)
  * [树莓派裸核程序开发 —— 从汇编到第一个C语言程序](https://blog.csdn.net/u014082689/article/details/89074600)
  * [树莓派裸机代码bootloader学习总结](https://blog.csdn.net/weixin_34001430/article/details/92686304)

---

## 五、raspi3-tutorial硬件测试用例

* 原始网址：[mirrors_bztsrc / raspi3-tutorial](https://gitee.com/mirrors_bztsrc/raspi3-tutorial)
* 本仓库中的地址：根目录/raspi3-tutorial/
* msys64中的地址：家目录 ~/raspi3-tutorial/
* 硬件是raspi3，64位ARM芯片，但因为有现成的代码，可以先熟悉编译环境，之后再在32位ARM上跑。

<center>表3 raspi3-tutorial各测试用例的描述</center>

|用例名称|作用|备注|
|---|---|---|
|00_crosscompiler|文档，只是描述编译器相关的内容||
|01_bareminimum|空程序，在汇编中死循环，只是为了验证编译器和模拟器安装正确，能够编译和运行||
|02_multicorec|写汇编boot，并引导C语言main函数运行||
|03_uart1|串口打印Hello world，从MSYS2控制台输出||
|04_mailboxes|CPU和GPU邮箱通信，通信成功后打印串口号||
|05_uart0|串口收发回环||
|06_random|打印随机数||
|07_delays|延时后打印||
|08_power|关机与重启||
|09_framebuffer|从屏幕显示未压缩的图片||
|0A_pcscreenfont|从屏幕显示点阵字库文字||
|0B_readsector|读SD卡扇区||
|0C_directory|读SD卡文件夹||
|0D_readfile|读SD卡文件||
|0E_initrd|根文件系统||
|0F_executionlevel|获取当前程序级别||
|10_virtualmemory|MMU虚拟内存映射||
|11_exceptions|测试异常中断||
|12_printf|测试printf输出||
|13_debugger|gdb调试输出||
|14_raspbootin64|一个简单的bootloader||
|15_writesector|写SD卡||

### 1）03_uart1

* 作用：串口打印Hello world，从MSYS2控制台输出
* 效果：

```shell
jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/03_uart1
$ make
rm kernel8.elf *.o >/dev/null 2>/dev/null || true
aarch64-linux-gnu-gcc -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles -c start.S -o start.o
aarch64-linux-gnu-gcc -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles -c main.c -o main.o
aarch64-linux-gnu-gcc -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles -c uart.c -o uart.o
aarch64-linux-gnu-ld -nostdlib -nostartfiles start.o main.o uart.o -T link.ld -o kernel8.elf
aarch64-linux-gnu-objcopy -O binary kernel8.elf kernel8.img

jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/03_uart1
$ make run
qemu-system-aarch64 -M raspi3b -kernel kernel8.img -serial null -serial stdio
Hello World!
```

### 2）04_mailboxes

* 作用：CPU和GPU邮箱通信，通信成功后打印串口号
* 效果：

```shell
jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/04_mailboxes
$ make
rm kernel8.elf *.o >/dev/null 2>/dev/null || true
aarch64-linux-gnu-gcc -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles -c start.S -o start.o
aarch64-linux-gnu-gcc -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles -c main.c -o main.o
aarch64-linux-gnu-gcc -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles -c mbox.c -o mbox.o
aarch64-linux-gnu-gcc -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles -c uart.c -o uart.o
aarch64-linux-gnu-ld -nostdlib -nostartfiles start.o main.o mbox.o uart.o -T link.ld -o kernel8.elf
aarch64-linux-gnu-objcopy -O binary kernel8.elf kernel8.img

jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/04_mailboxes
$ make run
qemu-system-aarch64 -M raspi3b -kernel kernel8.img -serial null -serial stdio
My serial number is: 0000000000000000
```

### 3）05_uart0

* 作用：串口收发回环（串口重定向到MSYS2命令行终端）
* 效果：

```shell
jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/05_uart0
$ make
rm kernel8.elf *.o >/dev/null 2>/dev/null || true
aarch64-linux-gnu-gcc -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles -c start.S -o start.o
aarch64-linux-gnu-gcc -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles -c main.c -o main.o
aarch64-linux-gnu-gcc -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles -c mbox.c -o mbox.o
aarch64-linux-gnu-gcc -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles -c uart.c -o uart.o
aarch64-linux-gnu-ld -nostdlib -nostartfiles start.o main.o mbox.o uart.o -T link.ld -o kernel8.elf
aarch64-linux-gnu-objcopy -O binary kernel8.elf kernel8.img

jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/05_uart0
$ make run
qemu-system-aarch64 -M raspi3b -kernel kernel8.img -serial stdio
My serial number is: 0000000000000000
aaaaddddd
asdfasfsafsa
```

### 4）07_delays

* 延时后打印

```shell
jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/07_delays
$ make run
qemu-system-aarch64 -M raspi3b -kernel kernel8.img -serial stdio
Waiting 1000000 CPU cycles (ARM CPU): OK
Waiting 1000000 microsec (ARM CPU): OK
Waiting 1000000 microsec (BCM System Timer): OK
```

### 5）08_power

* 关机与重启

```shell
jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/08_power
$ make run
qemu-system-aarch64 -M raspi3b -kernel kernel8.img -serial stdio
 1 - power off
 2 - reset
Choose one: 2

 1 - power off
 2 - reset
Choose one: 1

 1 - power off
 2 - reset
Choose one:
jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/08_power
```

### 6）09_framebuffer

* 从屏幕显示未压缩的图片

![img](./picture/09_framebuffer.png)

### 7）0A_pcscreenfont

* 从屏幕显示点阵字库文字

![img](./picture/0A_pcscreenfont.png)

### 8）0F_executionlevel

* 获取当前程序级别

```shell
jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/0F_executionlevel
$ jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/0F_executionlevel
$ make run
qemu-system-aarch64 -M raspi3b -kernel kernel8.img -serial stdio
Current EL is: 00000001
```

### 9）11_exceptions

* 测试异常中断

```shell
jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/11_exceptions
$ make run
qemu-system-aarch64 -M raspi3b -kernel kernel8.img -serial stdio
Synchronous: Data abort, same EL, Translation fault at level 2:
  ESR_EL1 0000000096000006 ELR_EL1 0000000000080CC4
 SPSR_EL1 00000000200003C4 FAR_EL1 FFFFFFFFFF000000

jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/11_exceptions
```

### 10）12_printf

* 测试printf输出

```shell
jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/12_printf
$ make run
qemu-system-aarch64 -M raspi3b -kernel kernel8.img -serial stdio
Hello World!
This is character 'A', a hex number: 7FFF and in decimal: 32767
Padding test: '00007FFF', '    -123'

jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/12_printf
```

### 11）13_debugger

* gdb调试输出

```shell
jim@DESKTOP-SVP3BEM MSYS ~/raspi3-tutorial/13_debugger
$ make run
qemu-system-aarch64 -M raspi3b -kernel kernel8.img -serial stdio
Synchronous: Breakpoint instruction
> run
 x0: 000000000008EF7C   x1: 0000000000000301   x2: 0000000000000070
 x3: 000000000000000B   x4: 0000000000024000   x5: 0000000000000000
 x6: 0000000000000000   x7: 0000000000000000   x8: 0000000000000000
 x9: 0000000000000000  x10: 0000000000000000  x11: 0000000000000000
x12: 0000000000000000  x13: 0000000000000000  x14: 0000000000000000
x15: 0000000000000000  x16: 0000000000000000  x17: 0000000000000000
x18: 0000000000000000  x19: 0000000000000000  x20: 0000000000000000
x21: 0000000000000000  x22: 0000000000000000  x23: 0000000000000000
x24: 0000000000000000  x25: 0000000000000000  x26: 0000000000000000
x27: 0000000000000000  x28: 0000000000000000  x29: 000000000007FFF0
x30: 000000000008EF7C  elr_el1: 8EF7C  spsr_el1: 600003C4
  esr_el1: F2000000  far_el1: 0
sctlr_el1: 30D00800  tcr_el1: 0
>
```

## 六、BCM2836芯片描述

### 1）BCM2836芯片资料

* 树莓派按时间的板子信息如下，因为嵌入式一般是用32位的CPU，所以我使用低版本树莓派，我会将要使用的型号加粗标注：

<center>表4 树莓派的所有板子</center>

|发布时间|名称|芯片|外设|
|---|---|---|---|
|2011-12|Raspberry Pi Model B|BCM2835 ARM1176JZF-S 700MHz 512M|有网口、无WiFi和蓝牙|
|2014-7-14|Raspberry Pi Model B+|同上，BCM2835 ARM1176JZF-S 700MHz 512M|同上|
|2014-11-11|Raspberry Pi Model A+|同上，BCM2835 ARM1176JZF-S 700MHz 512M|无网口、WiFi和蓝牙|
|2015-02-02|**Raspberry Pi 2 Model B**|**BCM2836** ARM **Cortex-A7** 900MHz 4核 1G|**有网口**、无WiFi和蓝牙|
|2015-11-26|Raspberry Pi Zero|BCM2835 ARM11 1GHz DDR512M|无网口、WiFi和蓝牙|
|2016-02-29|Raspberry Pi 3 Model B|BCM2837 ARM Cortex-A53 1.2GHz 64位4核 1GB|有网络、WiFi和蓝牙|
|2017-3-1|**Raspberry Pi Zero W**|**BCM2835 ARM11** 1GHz 512M|无网口，**有WiFi和蓝牙**|
|2018-3-4|Raspberry Pi 3 Model B+|BCM2837 ARM Cortex-A53 1.2GHz 64位4核 1GB|有网络、WiFi和蓝牙|
|2018-11-15|Raspberry Pi 3 Model A+|BCM2837B0 ARM Cortex-A53 1.4GHz 64位4核 1GB|无网络、有WiFi和蓝牙|
|2019-06-24|Raspberry Pi 4 Model B|BCM2711 ARM Cortex-A72 1.5GHz 64位4核 8GB|有网络、WiFi、蓝牙|

* *参考资料：*
  * [树莓派介绍以及FAQ](https://shumeipai.nxez.com/intro-faq)

* 我使用32位ARM Cortex-A7 4核的BCM2836芯片，该芯片的参数如下；2836的文档是以2835为基础的，所以也要看2835的文档：
  * BCM2836官网资料[BCM2836](https://www.raspberrypi.com/documentation/computers/processors.html#bcm2836)
  * BCM2835官网资料[BCM2835](https://www.raspberrypi.com/documentation/computers/processors.html#bcm2835)
  * BCM2835外设文档：[BCM2835 ARM Peripherals](https://datasheets.raspberrypi.com/bcm2835/bcm2835-peripherals.pdf)
  * BCM2835勘误表：[BCM2835 datasheet errata](https://elinux.org/BCM2835_datasheet_errata)
  * GPU手册：[VideoCore® IV 3D  Architecture Reference Guide](https://docs.broadcom.com/doc/12358545)
  * [博通GPU驱动](https://docs.broadcom.com/docs/12358546)
  * BCM2836外设：[bcm2836-peripherals.pdf](https://datasheets.raspberrypi.com/bcm2836/bcm2836-peripherals.pdf)
  * BCM2836 ARM Cortex-A7 MPCore技术参考手册：[Cortex-A7 MPCore Technical Reference Manual](https://documentation-service.arm.com/static/602cf701083323480d479d18?token=)
  * BCM2835 ARM11内核：[ARM1176JZF-S Technical Reference Manual r0p7](https://documentation-service.arm.com/static/5e8e294efd977155116a6ca3?token=)

* 芯片的Boot
  * 芯片的Boot在E2PROM中，是给GPU用的，GPU先启动，然后在引导ARM；Boot固件可以用工具更新，但它是闭源的
  * 详见[Updating the EEPROM Configuration](https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#raspberry-pi-4-boot-eeprom)

* *参考资料：*
  * [Raspberry Pi官网](https://www.raspberrypi.com/)

### 2）BCM2836芯片资源

* BCM2836是基于BCM2835的，只是在BCM2835的基础上将CPU从ARM11换成了ARM Cortex-A7，以为外设资源还需要看BCM2835的芯片手册。

<center>表5 博通BCM2836芯片的所有模块</center>

|模块名称|描述|备注|
|---|---|---|
|GPU|VideoCore IV，支持OpenGL ES 2.0，1080p 30帧 H.264和MPEG-4解码||
|HDMI|HDMI音频视频输出||
|USB|4个USB 2.0，Core和Phy用的是Synopsys IP，该模块被GPU所拥有||
|SD EMMC|支持MultiMedia和SD卡||
|以太网|100M||
|定时器|1个64位定时器，2个32位定时器||
|Mailbox|GPU和CPU核间通信|
|中断控制|GPU中断和ARM中断||
|UART|两个串口||
|SPI|SPI1、SPI2||
|BSC（I2C）|Broadcom Serial Controller (BSC)，BSC0~2三个，I2C||
|DMA|数据快速搬运，16个通道||
|GPIO|54个IO口||
|I2S PCM|音频输入输出||
|PWM|Pulse Width Modulator||
|SPI|SPI总线||

* ARM Cortex-A7支持ARM、Thumb和Thumb-2指令集。
  * [Arm技术文档分享|Cortex-A 系列处理器Cortex-A7文档（附PDF）](https://aijishu.com/a/1060000000103112)

## 七、BCM2836裸机编程

### 1）可以参考的教程

* Boot流程介绍：
  * 一般ARM芯片从0地址启动，而0地址默认是复位中断的入口，写了复位中断处理程序后，进一步向下执行就是配置堆和栈的地址与大小，配置系统频率、DDR内存，跳转到C语言Main()函数执行。
  * 而BCM2836是GPU先运行，并且GPU的Boot程序是闭源的，所以是GPU从0地址开始跑；
  * GPU先运行bootcode.bin这个程序，再引导start.elf程序运行，然后再引导kernel8.img这个ARM程序运行，ARM程序运行的起始地址是固定的0x80000，所以写ARM裸机程序的时候第一个代码段要指定到这个地址。
  * 写ARM裸机程序时，一些必要的芯片初始化也可以省略，因为GPU已经帮忙做了，外设寄存器地址从0x3F000000虚拟地址开始
  * 有关BCM2836 Boot的介绍详见本地文档[./raspi3-tutorial/README.md](./raspi3-tutorial/README.md) 的“About the hardware”小节。
  * BCM2836 ARM启动前的Boot程序下载地址：[Welcome to the Raspberry Pi Firmware Wiki](https://github.com/raspberrypi/firmware/wiki)
  * Boot固件下载地址2：[raspberrypi/firmware](https://github.com/raspberrypi/firmware/tree/master/boot)
  * 这里有树莓派官方的ARM Boot汇编代码：[tools/armstubs/armstub8.S](https://github.com/raspberrypi/tools/blob/master/armstubs/armstub8.S)

* 几个对裸机编程有帮助的教程：
  * [Baking Pi – Operating Systems Development](https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/os/)
  * 上面的教程：目的是讲述怎么用汇编编程，只支持Raspberry Pi Model B，BCM2835 ARM1176JZF-S，完全用汇编编写；控制LED灯和GPIO，控制GPU在屏幕上显示内容，绘制图形，用汇编实现printf，键盘输入。
  * [dwelch67/raspberrypi](https://github.com/dwelch67/raspberrypi)
  * 上面的教程：支持树莓派1和2，写ARM裸机程序，里面是一个个分开的用例，有串口、SPI、显示、解压缩、显示图片、ARM Bootloader等，值得一看。
  * [PeterLemon/RaspberryPi](https://gitee.com/mirrors_PeterLemon/RaspberryPi) ，https://github.com/PeterLemon/RaspberryPi
  * 上面的教程：主要是汇编，写了文件解码、音频播放、屏幕显示、绘图、播放视频等。
  * [rsta2/circle](https://github.com/rsta2/circle)
  * 上面的教程：主要是C++写到树莓派裸机程序，很全，各个硬件模块的驱动都有
  * [DexOS the game console OS](http://dex-os.github.io/) 一个用汇编写的操作系统
  * [DexBasic For the Raspberry pi](http://dex-os.github.io/DexBasic/DexBasic.htm) 一个树莓派汇编编译器
  * [A Raspberry Pi 3 (formerly Raspberry Pi 2 v1.1) based games console, including RTOS, GPU driver, SDK](https://jaystation2.maisonikkoku.com/) 树莓派GPU程序

* *参考网址：*
* https://github.com/raspberrypi 里有树莓派的一些仓库集合，有用的一些仓库有：
  * https://github.com/raspberrypi/tools
  * Source code for ARM side libraries for interfacing to Raspberry Pi GPU：https://github.com/raspberrypi/userland
  * https://github.com/raspberrypi/libcamera
  * https://github.com/raspberrypi/firmware
  * The official documentation for Raspberry Pi computers and microcontrollers：https://github.com/raspberrypi/documentation
  * https://github.com/raspberrypi/linux
  * Github链接如果打不开，则可以将链接放到Gitee里搜索，一般都有人上传镜像

### 2）本地裸机工程介绍

