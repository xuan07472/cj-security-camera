# ARM Cortex-A7汇编语言、GNU伪指令和链接脚本介绍

|作者|将狼才鲸|
|---|---|
|创建日期|2022-11-18|

---

## 一、Cortex-A7介绍

* ARM Cortex-A7是32位CPU核，使用A7的芯片有NXP的i.MX7、博通BCM2836等。
* A7支持ARM、Thumb、Thumb-2、ThumbEE指令集；
* ARM Cortex-A7 MPcore属于ARM v7-A架构，处理器支持1~4个核心。

* *参考网址：*
  * [ARM Cortex-A7 MPCore架构基础知识](https://www.likecs.com/show-225656.html)

## 二、Cortex-A7汇编语言和指令介绍

* 写汇编代码时，一条语句并不能决定它使用的是哪种指令集，而是由编译器在编译时按最优化的方式决定它翻译成哪种指令集；也可以在编译器中指定固定使用哪种指令；Unified Assembler Language (UAL) is a common syntax for ARM and Thumb instructions，Code written using UAL can be assembled for ARM or Thumb for any ARM processor。

* 一个汇编关键字，往往是由很多条二进制指令组成的，源寄存器或目的寄存器的不同都会是一条新的汇编指令，即使汇编关键字一样。

* 汇编的写法根据编译器的不同，有GNU风格和ARM风格，GUN风格为小写，ARM风格为大写，一般只需要掌握GNU语法即可。
  * GNU AS汇编器官方文档：[GNU Assembler Manual - ESA](http://microelectronics.esa.int/erc32/doc/as.pdf) ，包含各种伪指令
  * GNU AS汇编器官方在线阅读地址：[The GNU Assembler](https://debrouxl.github.io/gcc4ti/gnuasm.html)
  * ARM汇编语言官方文档：[ARM Compiler toolchain](https://documentation-service.arm.com/static/5ea068ec9931941038de5e8e?token=) ，具体的汇编关键字如MOV、BL等介绍详见第五章“5.2 Subroutines calls”
  * ARM汇编语言文档在线阅读地址：[ARM Compiler toolchain Using the Assembler Version 4.1](https://developer.arm.com/documentation/dui0473/c/writing-arm-assembly-language)

* 具体常用的ARM汇编关键字这里不介绍了，网上一搜一大把。

* *参考网址：*
  * [ARM汇编基础（Cortex-A7）](https://www.codenong.com/cs106126535/)
  * [裸机开发（2） Cortex-A7简介 常用ARM汇编指令](https://blog.csdn.net/weixin_41898804/article/details/105789011)
  * [交叉编译、GNU 汇编语法、Cortex-A7 常用汇编指令、IO使用、使用汇编点亮LED](https://blog.csdn.net/fengge2018/article/details/105153058)
  * [armv7-A系列5- arm 指令集以及编码](https://zhuanlan.zhihu.com/p/362760953)
  * [armv7-A系列9-arm硬件汇编指令](https://zhuanlan.zhihu.com/p/362826125)
  * [AMRv9影响下一个十年！一文了解ARM指令集发展史](https://view.inews.qq.com/k/20210408A09TI600)
  * [ARM-汇编指令集（总结）](https://zhuanlan.zhihu.com/p/164415889)

## 三、ARM汇编关键字、GNU伪指令和链接脚本介绍

<center>表1  ARM汇编关键字和GNU伪指令</center>

|关键字|作用|举例|
|---|---|---|
|arm-none-eabi-ld -T|链接器指定链接脚本文件|arm-none-eabi-ld -T link.ld|
|MEMORY{}|指定内存区域|MEMORY{ram:ORIGIN=0x0000,LENGTH=0x1000000}|
|ram:|指定ram大小||
|ORIGIN=0xXX|指定RAM起始地址|ORIGIN=0x0000|
|LENGTH=0xXXXXXXXX|指定RAM长度|LENGTH=0x1000000|
|SECTIONS{}|指定段，如代码段||
|*|匹配任意长度的字符|*(.text*)|
|> ram|将段放到内存中|.text : { *(.text*) } > ram|
|.text|只读的代码段||
|.bss|未初始化的全局变量段||
|.globl xxx|给xxx一个外部属性，类似于C语言的extern|.globl _start|
|xxx:|标号，也是函数名|_start:|
|b xxx|跳转指令|b start|
|.space 0xXX,0|将当前区域的0xxx长度的内容用0填充|.space 0x1000-0x4,0|
|mrc|将CP15存储类协处理器的寄存器读到ARM中|mrc p15,0,r0,c0,c0,5|
|mov|将后面的值赋给前面的变量|mov r1,#0xFF|
|ANDS R0,R1,#0x01|R0=R1&0x01||
|bne xxx|如果它之前的比较指令 值1 != 值2 ，程序跳转到xxx处||
|bl xxx|跳转到xxx函数，函数带返回||
|b xxx|跳转到xxx函数，函数无返回||
|b .|.是本行的地址，不断跳转到本行，也就是死循环||
|//或#或@|行注释|@ 这是注释，行注释不支持分号; 但可以用;@|
|/* */|块注释||
|sp|栈顶指针值|mov sp, #0x8000|
|cmp|比较两个值，后面一般跟着bne进一步判断比较结果|cmp r1, #1|
|ldr|将后面值中的地址值付给前面的寄存器|ldr r1, =0x1000|
|=0xXXXX|=等号是将地址值转为绝对地址||
|str|将前面的值放到后面的地址中去|str r0,[r1]|
|[]|将值作为地址|[r1]|
|bx XXX| 带状态切换的跳转指令，可以跳转到ARM指令集也可以跳转到Thumb指令集 ||
|bx lr|函数返回|等同于return;|
|strh|将前面寄存器中低16位赋值到后面的地址中||
|strb|将前面寄存器中低8位赋值到后面的地址中||
|dsb|数据同步隔离，保证前面的数据读写都完成；类似于fflush(stdio)||
|isb|指令同步隔离，保证前面所有的指令都已执行完毕||
||||
||||
||||

