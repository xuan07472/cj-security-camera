/*******************************************************************************
 * \brief	汇编boot，和一些必须要用汇编实现的函数接口
 * \note	File format: UTF-8
 * \note	GNU汇编不能使用;分号做注释，但可以用;@，分号+@；行注释和块注释和C语言一样，
 *			行注释还可以是@、#
 * \author	注释作者：将狼才鲸
 * \date	注释日期：2022-11-20
 * \note	参考网址：
 *			[常见的GNU汇编伪指令](https://blog.csdn.net/oqqHuTu12345678/article/details/125694068)
 *			[Using as The gnu Assembler] GNU官方文档的“7.59 .space size , fill”小节
 *			[协处理器CP15介绍—MCR/MRC指令](https://blog.csdn.net/daocaokafei/article/details/114292514)
 *			[DUI0588B_assembler_reference.pdf] ARM官方文档的“3.58 MRC, MRC2, MRRC and MRRC2”
 *			[DDI0464F_cortex_a7_mpcore_r0p5_trm.pdf] ARM官方文档的“4.2.1 c0 registers”
 *				和“4.3.5 Multiprocessor Affinity Register”
 *			[ARM数据处理指令——逻辑运算指令](https://www.csdn.net/tags/NtDakg0sNTMyMzUtYmxvZwO0O0OO0O0O.html)
 *			[【ARM学习笔记】ARM汇编指令：B、BL、BX、BLX的区别](https://blog.csdn.net/szullc/article/details/122333827)
 *			[汇编 cmp_【干货分享】从0开始学ARM，ARM汇编指令原来如此简单]
 *				(https://blog.csdn.net/weixin_39638623/article/details/111344950)
 *			[arm汇编之 bne与beq](https://blog.csdn.net/fanrwx/article/details/56048933)
 *			[ARM 汇编中的 “B .“ 语句意义](https://blog.csdn.net/weixin_44058570/article/details/120265946)
 *			[ARM 汇编指令 ADR 与 LDR 使用](https://blog.csdn.net/Emily_rong_2021/article/details/122435714)
 *			[ARM的ADN指令和ANDS指令有什么不同？](https://bbs.csdn.net/topics/390748485)
 *			[ARM汇编指令：STRH指令、STRB指令、STR指令、LDR指令、LDRH]
 *				(https://wenku.baidu.com/view/47145ae8a2c7aa00b52acfc789eb172ded6399c3.html)
 ******************************************************************************/

/* 最前面的代码是reset复位中断入口，后面紧跟着的是其它中断的入口，但是后面的中断处理在当前都省略了没添加 */

/* 给_start一个外部链接属性，类似于C语言的extern */
.globl _start	/* _start是一个系统默认的起始函数名？ */

/* 冒号前的是标号，也是函数名 */
/*
 * \brief	4个CPU核共用的复位中断函数，会进入4次？
 */
_start:
    b skip	/* 跳转到skip函数 */

/* 将当前区域的0x1000-0x4长度的内容用0填充 */
.space 0x1000 - 0x4, 0

/*
 * \brief 名为skip的函数，从CPU寄存器判断哪个CPU核，分别执行不同的boot流程
 */
skip:
	/* 第一个参数固定为p15，协处理器的固定操作码0，第三个ARM寄存器，第四个CP15  协处理器寄存器，协处理器附加寄存器，协处理器操作码 */
    mrc p15, 0, r0, c0, c0, 5	/* 5操作码+r0指的是MPIDR ; CP15存储类协处理器读数据到ARM CPU，获取Multiprocessor Affinity Register */
    mov r1, #0xFF				/* r1 = 0xFF */
    ands r1, r1, r0				/* r1 = r1 & r0，r1只保留r0的低8位 */
	/* "4.3.5 Multiprocessor Affinity Register" of DDI0464F_cortex_a7_mpcore_r0p5_trm.pdf
	 * r0里当前存放的是MPIDR寄存器，bit0~1是CPU ID，指示CPU单核~4核；bit8~11存放Cluster ID，
	 * 和MT、U一起指示是否是多CPU架构、多线程。
	 */
    bne not_zero				/* 如果上面语句r1 & r0 != 0，程序跳转到not_zero处；如果是CPU1、2、3则跳转，如果是是CPU0则继续往下执行 */
	/*
	 * 如果是CPU0则会往下执行，如果是CPU1、2、3则会在上面调用的函数中死循环
	 * "5.14 Load and store multiple instructions available in ARM and Thumb" of DUI0473C_using_the_arm_assembler.pdf
	 * The stack pointer (SP) is the base register, and is always updated.
	 * "Example 5-7 Block copy using LDM and STM" of DUI0473C_using_the_arm_assembler.pdf
	 */
    mov sp, #0x8000			/* sp是stack栈顶指针，用于函数参数的压栈和弹栈，也存放函数指针 */
    bl notmain				/* CPU0跳转到notmain函数，函数带返回 */

/*
 * \brief	所有函数执行完之后的死循环，将CPU卡住
 */
hang: b hang				/* 跳转到hang函数，函数无返回；main函数执行完之后进入死循环 */

/*
 * \brief		BCM2826初始化后面3个CPU核
 * \details		也可以不实现CPU1~3的程序跳转，直接只执行上面的代码即可
 * \param[in]	r1：MPIDR寄存器中低字节值，bit0~1是CPU ID，指示CPU单核~4核中的哪一个
 */
not_zero:
	/* 第二个操作数如果是立即数，bit:[11-8]表示操作数向左移动的位数 / 2, bit:[7-0]表示最终的操作数；
	   比较r1和立即数1，结果为0或者非0，将结果存到cpsr寄存器相应的condition位 */
    cmp r1, #1		/* 如果是第2个CPU核 */
    beq core_one	/* 如果r1 == 1，跳转到core_one */
    cmp r1, #2		/* 如果是第3个CPU核 */
    beq core_two
    cmp r1, #3		/* 如果是第4个CPU核 */
    beq core_three
    b .				/* 跳转到本行，死循环，当前CPU的主函数退出后卡在这里 */

/*
 * \brief	cpu1执行栈顶的函数
 * \param[in, out]	r0：输入为MPIDR寄存器中的值，输出为栈顶的函数地址
 */
core_one:
	ldr r1, =0x1000 /* 将0x1000转换为绝对地址后赋值为r1；这个值能控制当前是CPU1？ */
	str r0, [r1]	/* 将r0中的数据放入到r1存储的地址中去 */
    mov sp, #0x6000	/* 赋值CPU核1的stack栈顶地址 */
    mov r1, #0		/* r1 = 0 */
    str r1, [sp]	/* *SP = 0 */
core_one_loop:
    ldr r0, [sp]	/* r0 = &sp */
    cmp r0, #0		/* if (r0 == 0) */
    beq core_one_loop	/* 如果CPU1栈顶没有代码，则一直在此死循环 */
    bl hopper		/* 跳转到sp栈顶函数的地址 */
    b hang			/* 只是让CPU1进入死循环？不影响其它CPU运行？ */

/*
 * \brief	cpu2执行栈顶的函数
 * \param[in, out]	r0：输入为MPIDR寄存器中的值，输出为栈顶的函数地址
 */
core_two:
	ldr r1, =0x1004
	str r0, [r1]
    mov sp, #0x4000
    mov r1, #0
    str r1, [sp]
core_two_loop:
    ldr r0, [sp]
    cmp r0, #0
    beq core_two_loop
    bl hopper
    b hang

/*
 * \brief	cpu3执行栈顶的函数
 * \param[in, out]	r0：输入为MPIDR寄存器中的值，输出为栈顶的函数地址
 */
core_three:
	ldr r1, =0x1008
	str r0, [r1]
    mov sp, #0x2000
    mov r1, #0
    str r1, [sp]
core_three_loop:
    ldr r0, [sp]
    cmp r0, #0
    beq core_three_loop
    bl hopper
    b hang

/*
 * \brief	跳转到sp栈顶的函数地址
 * \param[in]	r0：sp栈顶指针
 */
hopper:
    bx r0		/* 跳转到sp栈顶的函数地址，可以跳转到ARM指令集也可以跳转到Thumb指令集 */

/*
 * \brief		写寄存器
 * \details		这个函数会在别的文件中调用
 * \param[in]	r0，要写的寄存器地址
 * \param[in]	r1，要写入的寄存器值
 */
.globl PUT32		/* extern void PUT32(unsigned int *r0, unsigned int r1); */
PUT32:
    str r1, [r0]	/* *r0 = r1 */
    bx lr			/* return; 函数返回 */

/*
 * \brief
 */
.globl PUT16		/* extern void PUT16(unsigned int *r0, unsigned int r1); */
PUT16:
    strh r1, [r0]	/* *r0 = r1 &0x0000FFFF */
    bx lr			/* return */

.globl PUT8			/* extern void PUT8(unsigned int *r0, unsigned int r1); */
PUT8:
    strb r1, [r0]	/* *r0 = r1 &0x000000FF */
    bx lr

/*
 * \brief	读取寄存器
 * \param[in]	r0：输入的地址
 * \return		r0：返回读取的值
 */
.globl GET32		/* extern unsigned int GET32( unsigned int *r0); */
GET32:
    ldr r0, [r0]	/* r0 = *r0 */
    bx lr

/* 获取当前PC地址 */
.globl GETPC		/* extern unsigned int GETPC(void); */
GETPC:
    mov r0, lr
    bx lr

/* 该函数未被调用 */
.globl BRANCHTO
BRANCHTO:
    mov r12,#0
    mcr p15, 0, r12, c7, c10, 1
    dsb	/* 数据同步隔离，保证前面的数据读写都完成；类似于fflush(stdio) */
    mov r12, #0
    mcr p15, 0, r12, c7, c5, 0
    mov r12, #0
    mcr p15, 0, r12, c7, c5, 6
    dsb
    isb	/* 指令同步隔离，保证前面所有的指令都已执行完毕 */
    bx r0

/* 空函数，用作延时 */
.globl dummy	/* extern void dummy(unsigned int r0); */
dummy:
    bx lr

/* 获取CPSR寄存器 */
.globl GETCPSR	/* extern unsigned int GETCPSR(void); */
GETCPSR:
    mrs r0, cpsr
    bx lr

/* 获取SCTLR寄存器 */
.globl GETSCTLR	/* extern unsigned int GETSCTLR(void); */
GETSCTLR:
    mrc p15, 0, r0, c1, c0, 0
    bx lr

/* 获取MPIDR寄存器 */
.globl GETMPIDR	/* extern unsigned int GETMPIDR(void); */
GETMPIDR:
    mrc p15, 0, r0, c0, c0, 5 ;@ MPIDR
    bx lr

;@-------------------------------------------------------------------------
;@
;@ Copyright (c) 2012 David Welch dwelch@dwelch.com
;@
;@ Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
;@
;@ The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
;@
;@ THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
;@
;@-------------------------------------------------------------------------
