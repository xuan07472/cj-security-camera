# MSYS2安装步骤

|作者|将狼才鲸|
|---|---|
|创建日期|2022-11-15|

---

* 简介：MSYS2是一个Windows下的Linux Shell命令终端，MinGW是一个能将Linux源码编译成Windows程序的编译工具集。
  * MSYS2官网：[MSYS2 - Software Distribution and Building Platform for Windows](https://www.msys2.org/)
  * MSYS2支持的一些包和对应的尺寸：[packages.msys2.org/repos](https://packages.msys2.org/repos) ，MinGW的尺寸都很大，有几十G，如果你不需要从源码编译出Windows下的软件，则可以不下载MinGW，而只使用经过MinGW编译好的软件。
  * MSYS2支持的基础软件包：[MSYS2 Base Packages](https://packages.msys2.org/base)，内容非常多，像ARM交叉编译工具和QEMU都在这里面；很多工具你在网上找不到安装教程时，不妨来这里翻一翻。
  * MSYS2支持的其它软件包：[MSYS2 Packages](https://packages.msys2.org/package)

* *参考网址：*
  * [全网最详细msys2编译libx264库](https://blog.csdn.net/nodeman/article/details/106431858)  
  * [清华大学开源软件镜像站](https://mirrors.tuna.tsinghua.edu.cn/msys2/distrib/x86_64/)  
  * [安装MSYS2 Gcc环境](https://www.moguf.com/post/win10installgcc)  
  * [ubuntu添加环境变量的四种方法](https://blog.csdn.net/K_K_yl/article/details/119756206)  
  * [LINUX修改.bashrc之后，生效的办法](https://blog.csdn.net/quantum7/article/details/82142173)  
  * [在 msys2 中安装软件 vim git gcc等](https://blog.csdn.net/eloudy/article/details/120159510) 
  * [Ubuntu添加gcc头文件搜索路径](https://blog.csdn.net/qq_44986592/article/details/112061665) 
  * [MSYS2与mingw32和mingw64的安装](https://www.cnblogs.com/juluwangshier/p/12015699.html)  
  * [pacman常用命令](https://www.jianshu.com/p/4da41f67a7d9)  
  * [在 msys2 中的 mingw64 、 ucrt64 、 clang64 的区别与相同点有啥？](https://www.zhihu.com/question/463666011/answer/1927907983)

* 要手动安装gcc、make、git等常用的编译工具  
* 如果要编译32位的程序，还需要安装mingw-w64-i686、ncurses、ncurses-devel  
