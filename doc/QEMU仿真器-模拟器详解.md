# QEMU仿真器-模拟器详解  

|作者|将狼才鲸|
|---|---|
|创建日期|2022-05-28|

## 一、QEMU源码分析  
QEMU的main函数定义在/vl.c中
所有的硬件设备都在/hw/ 目录下面，所有的设备都有独自的文件，在vl.c中的machine _init中初始化

qemu源码，根目录下就有一些.c源文件和一些文件夹，可以直接在docs/文件夹下看文档。  
qemu/docs/index.rst  
qemu/docs/about/index.rst  
   about/index  
   system/index  
   user/index  
   tools/index  
   interop/index  
   specs/index  
   devel/index  
本地文档中没有完善的从头到尾的描述。  

官网在线文档：  
https://wiki.qemu.org/Documentation  
https://gitlab.com/qemu-project/qemu/-/tree/master/docs  
https://en.wikibooks.org/wiki/QEMU  
https://wiki.qemu.org/Documentation/Architecture  

*参考网址：*  
1. 有结构框图：  
[QEMU虚拟机(一)、源码分析概论](https://blog.csdn.net/weixin_38387929/article/details/120121636)  
2. 有函数调用关系图：  
[QEMU学习笔记-源码分析01-module infrastracture](https://www.icode9.com/content-1-36779.html)  
3. 设备模式qdev描述：  
[QEMU’s new device model qdev](http://www.linux-kvm.org/images/f/fe/2010-forum-armbru-qdev.pdf)  
4. 整体框架，有QEMU main()函数的位置：  
[qemu源码架构](http://t.zoukankan.com/CasonChan-p-4875373.html)  
5. QEMU中断  
[qemu-kvm 中断虚拟化](http://blog.chinaunix.net/uid-26941022-id-3510665.html)  
6. 其它
[QEMU的PCI总线与设备](http://blog.chinaunix.net/uid-26941022-id-3510663.html)  
[QEMU的对象模型-QOM](https://blog.csdn.net/sungeshilaoda/article/details/97890633)  
[Qemu VirtIO设备模拟分析1-virtio的QOM分析(以VirtIONetPCI为例)](https://blog.csdn.net/sungeshilaoda/article/details/89382983)  
[QEMU体系架构分析(2)](https://blog.csdn.net/sungeshilaoda/article/details/100688002)  
[virtio代码分析(一)-qemu部分](https://zhuanlan.zhihu.com/p/308062561)  
[QEMU软件虚拟化-TCG源码分析](https://blog.csdn.net/song_lee/article/details/123962341)  
[关于qemu的二三事（5）————qemu源码分析之参数解析](https://blog.csdn.net/Benjamin_Xu/article/details/72824904)  
[关于qemu的二三事（6）————qemu源码分析之vcpu](https://blog.csdn.net/Benjamin_Xu/article/details/72862351)  
[qemu源代码分析 （一）](http://blog.chinaunix.net/uid-22166872-id-3856642.html)  
[Linux虚拟化KVM-Qemu分析（四）之CPU虚拟化](https://blog.csdn.net/weixin_38387929/article/details/119985880)  

qemu/softmmu/vl.c  
qemu_init_board
qemu_init()
qemu/softmmu/main.c
main()



## 二、QEMU实践步骤  

