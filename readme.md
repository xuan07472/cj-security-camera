# 项目介绍：开源安防摄像机（嵌入式软件）

|作者|将狼才鲸|
|---|---|
|创建日期|2022-11-14|

* Gitee源码和工程地址：[才鲸嵌入式 / 开源安防摄像机（嵌入式软件）](https://gitee.com/langcai1943/cj-security-camera)
* CSDN文章地址：[项目介绍：开源安防摄像机（嵌入式软件）](https://blog.csdn.net/qq582880551/article/details/127857259)
* *注：文章中的子文档链接需在Gitee中的readme.md仓库介绍中才能点开，我设置的是相对地址，也可以在Gitee仓库的doc文件夹下手动点开。*

---

* 简介：使用ARM Cortex-A7 32位内核、带有GPU（2D 3D显示加速、图片和音频视频编解码）的博通BCM2837芯片（树莓派2B同款硬件，但不使用树莓派的系统和软件），在QEMU模拟器中运行，实现安防摄像机、音视频播放器等嵌入式设备的功能。

|**依赖的硬件资源**|详情|备注|
|---|---|---|
|QEMU BCM2837芯片模拟器|900MHz 4核 ARM Cortex-A7 CPU，VideoCore IV 双核 GPU（2D 3D显示加速、视频编解码），1GB 内存，100M以太网，HDMI显示，USB2.0 x 4，SD卡，音频输出，GPIO，摄像头输入，液晶屏接口，串口，SPI，I2C等嵌入式通用模块|树莓派2B同款硬件|
|**编写的软件模块**|……正在进行中……||
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

1. 首先，需要Linux或者Windows MinGW等环境，如果你是第一次使用Linux，则不应该摸索Windows下的MinGW环境，这应该是对Linux已经很熟悉之后才做的事，因为在里面装软件很麻烦；你应该直接使用Ubuntu或其它Linux发行板，推荐在Windows下使用VMware虚拟机安装Ubuntu；具体的过程略。

2. Ubuntu下安装QEMU，这也等同于准备好了一块硬件开发板，过程略。

3. Ubuntu下安装ARM交叉编译工具，过程略。

4. 编译程序，运行程序。

* 如果你以前用过树莓派，那么请忘掉它，我们按照嵌入式的模式来。

* 写树莓派的底层程序，并不能像8051或普通MCU芯片一样，使用汇编，从零地址开始的复位中断开始，能够控制芯片上电后执行的第一条指令；树莓派上电后是芯片里面的GPU先开始运行，并且这部分代码是不公开的，GPU底层的寄存器介绍也是不公开的，只能加载官方提供的GPU的驱动；GPU上电后再引导ARM CPU运行。
* 但其实如果不是在芯片原厂，一般嵌入式开发人员也不需要知道芯片开发包里面的boot是如何实现的，编译器里面的C标准库是如何实现的，中断向量表和堆栈是如何分配的，各个驱动模板是如何实现的，操作系统是怎么移植的；能用就行。

### 1）安装Linux环境

* 可以在Windows下安装Msys2+MinGW32+MinGW64，或者安装Cygwin，这都是Linux运行环境；如果安装了Git，里面也会自带精简版的MinGW64；如果你有已经安装过MinGW环境的朋友，特别是他已经安装好了树莓派交叉编译工具和其它工具，你可以将他安装过的文件夹拷过来，在你的电脑上也同样可以点开即用，换句话说就是安装过一次以后的MinGW是绿色软件，只是文件比较大，会有几十G。
* 也可以先安装VMware Player虚拟机，然后在虚拟机中安装Ubuntu系统，这是一个Linux发行版；直接使用Linux系统，安装软件的教程和各种资料会比MingW更方便；如果你有已经在虚拟机中安装过Linux的朋友，特别是他在已经安装好了树莓派交叉编译工具、QEMU和其它工具，你可以将他安装过的文件夹拷过来。
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

* 写在前面，我会提供已经安装好各种工具的MSYS2环境，如果你没用过Linux，建议你直接下载使用，或者改用VMware Player虚拟机+Ubuntu，因为MSYS2中安装软件的教程很难快速找到，需要有一些使用Linux的经验才知道怎么安装特定软件；我的MSYS2环境添加了32位和64位的交叉编译工具，他们的来源不一样，后面会详述。

* 下面是从头到尾的工具软件安装步骤：
  * 推荐使用MSYS2+MinGW32+MinGW64，基本上开发过程中你能在Linux下实现的，也都能在这个环境下实现，只是有些教程没有Ubuntu下那么好找。
  * MSYS2的安装教程详见本仓库**子文档**：[《04_MSYS2安装步骤.md》](./doc/04_MSYS2安装步骤.md)

<center>表1 MSYS2、MinGW和Cygwin的关系</center>

|软件名|版本|作用|特点|
|---|---|---|---|
|MSYS|MSYS，MSYS2|Linux命令行终端：Shell，Bash|没有在Windows下编译Linux程序的工具集，会自带已经被MinGW编译好的一些包；脱胎于Cygwin，但容量更小；MSYS2是因为MSYS常年不更新而新组的的一个项目；MSYS2安装完后的文件名为msys64，你可以将你安装好之后的msys64文件夹打包发给别人，这样别人无安装就可以用了，只是容量有点大，几十G|
|MinGW|MinGW32，MinGW64|一组编译工具链|编译后生成的是纯粹的Windows程序；它自带的命令行终端很难用也不全，要和MSYS2终端配合使用；MinGW64是因为MinGW32常年不更新而新组的的一个项目|
|Cygwin|Cygwin|编译工具+命令行|有模拟层，将Linux API转成Windows API再执行程序，效率低，容量大，速度慢，2010年左右在Windows下搭建交叉编译环境时多用它|

* *参考网址：*
  * [CygWin、MingW、MSYS之间的关系](https://www.jianshu.com/p/09198f6e0a3c)
  * [Cygwin、Msys、MinGW、Msys2的区别与联系(转)](https://blog.csdn.net/u012294613/article/details/126460773)
  * [Cygwin、MinGw、mingw-w64,MSys msys2区别与联系](https://www.cnblogs.com/zengkefu/p/7371943.html)
  * [MSYS2+MinGW32 编译 QEMU需做的准备工作](https://blog.csdn.net/mozart_cai/article/details/79680685)
  * [在Windows上编译QEMU](https://blog.csdn.net/weixin_34062329/article/details/91654482)

#### 4.1 安装MSYS2

1. 我当前下载的版本是msys2-x86_64-20221028.exe
  * 网上的安装教程是[使用msys2打造优雅的开发环境](https://www.cnblogs.com/52fhy/p/15158765.html)
  * 在官网主页找到下载链接：[github.com/msys2/msys2-installer/releases/download/2022-10-28/msys2-x86_64-20221028.exe](https://github.com/msys2/msys2-installer/releases/download/2022-10-28/msys2-x86_64-20221028.exe) ，85M左右，这只是一个安装器，不是全部的软件；这是GitHub的地址，有时候下载慢，有时候无法访问；这个可下载的软件是CICD自动生成的，国内的Gitee镜像也没有这个下载包；但你也可以在网上其它的地方比如网盘之类的找到这个文件的下载。
2. 我将软件安装在D盘根目录，软件会安装在d:\msys64中，安装目录不能有空格、中文。
3. 安装完之后先不打开软件，先将国外镜像地址换成国内镜像地址，参考上方教程。
4. 电脑配置环境变量，在PATH中增加一行D:\msys64\usr\bin
  * [win10环境变量怎么设置 win10设置环境变量的方法](https://www.win7zhijia.cn/win10jc/win10_47252.html)
5. 双击运行主目录下的mingw64.exe或者msys2.exe都可以，其它的exe有些是32位的，有些是编译器不是用的gcc。

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

* 树莓派提供了在Linux下使用的交叉工具包的文件夹名为gcc-linaro-arm-linux-gnueabihf-raspbian-x64，使用的编译器名为arm-linux-gnueabihf-gcc，下载地址[raspberrypi-tools/ arm-bcm2708](https://gitee.com/qianchenzhumeng/raspberrypi-tools/tree/master/arm-bcm2708)。

* GNU官方提供了树莓派在Windows中使用的交叉工具包，默认的工具是使用Visual Studio +  VisualGDB来进行编译的。
  32位地址：[Prebuilt Windows Toolchain for Raspberry Pi](https://gnutoolchains.com/raspberry/)
  64位地址：[Prebuilt Windows Toolchain for Raspberry Pi (64-bit)](https://gnutoolchains.com/raspberry64/)

* ARM在Windows下自带的交叉编译工具为gcc-arm-none-eabi-10.3-2021.10-win32.exe，网页路径在https://developer.arm.com/downloads/-/gnu-rm ，交叉编译工具名为arm-none-eabi-gcc，我们不使用树莓派自带的交叉编译工具，而直接使用ARM的；因为树莓派没有在MinGW下编译它的交叉编译工具，而我也不想在Cygwin环境使用树莓派的Linux交叉编译工具。

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
  
* *参考网址：*
  * [Windows下编译树莓派pico C\C++（Building on MS Windows）](https://blog.csdn.net/m0_45961169/article/details/127282390)
  * [树莓派 交叉编译环境搭建（Win 7）](https://www.cnblogs.com/easy-busy/p/4402218.html)
  * [【交叉编译踩坑指北（二）】windows10下VScode构建树莓派pico开发环境（C/C++）](https://blog.csdn.net/SuperiorEE/article/details/127380128)
  * [树莓派2 raspyberry Pi2 交叉编译app](https://www.cnblogs.com/zhangjiankun/p/4855169.html)
  * [Windows10下 交叉编译aarch64(ARMv8)架构Qt5.12.11库](https://blog.csdn.net/y_q_m/article/details/120319055)

#### 4.4 用现成的程序从QEMU运行树莓派

* 在以下网址https://gitee.com/mirrors_bztsrc/raspi3-tutorial/tree/master/01_bareminimum 下载编译好的树莓派程序，我已下载好，存放在msys64家目录下的01_run文件夹中
* 使用命令运行：/mingw64/bin/qemu-system-aarch64 -M raspi3b -kernel ~/raspi/01_run/kernel8.img -d in_asm
* 能看到出现了QEMU窗口，并显示了hello world。
效果如下：![img](./picture/01_QEMU_RUN.png)

#### 4.5 交叉编译工具编译程序，并在树莓派QEMU模拟中运行


---

* 树莓派QEMU运行

## 五、开发步骤

### 1）01_Helloworld

* 第一个裸机程序。
* 直接参考https://github.com/dwelch67/raspberrypi教程。
* 参考[Tutorial 05 - UART0, PL011](https://gitee.com/mirrors_bztsrc/raspi3-tutorial/tree/master/05_uart0)

---

* 树莓派的底层固件（Bootloader）是闭源的，但可以在此基础上引导自己的U-Boot、Linux kernel。

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
  * 
