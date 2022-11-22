/*******************************************************************************
 * \brief	异常和中断入口，ARM Cortex-A7执行的第一行代码
 * \details	芯片上电的0地址开始是复位中断、系统和外设中断、系统异常的入口；
 *			BCM2836的0地址被最先上电的GPU使用了，ARM Cortex-A7 core 0的起始地址
 *			是0x8000，core 1的起始地址是0x6000，core 2的起始地址是0x4000，
 *			core 3的起始地址是0x2000；U-Boot(BootLoader)所担任的任务被GPU运行的
 *			bootcode.bin和start.elf实现了。
 * \note	File format: UTF-8
 * \author	将狼才鲸
 * \date	2022-11-21
 * \remarks	参考代码：
 *			[mirrors_dwelch67 / raspberrypi]
 *				(https://gitee.com/mirrors_dwelch67/raspberrypi/blob/master/boards/pi2/SVC_BOOT/uart02/vectors.s)
 *				(https://gitee.com/mirrors_dwelch67/raspberrypi/blob/master/boards/pi2/SVC/blinker05/vectors.s)
 * \remarks	GNU汇编使用C语言的斜杠星进行块注释，使用//、@、#三种方式进行行注释，
 *			不支持Keil MDK的;分号做行注释，但是支持;@分号和@一起进行行注释
 ******************************************************************************/

.globl _start				@ 向别的文件输出函数名或地址

/*
 * \brief	中断向量表
 * \note	_start代码段存放在0x8000的内存位置，这是由link.ld链接文件中决定的，
 *			0x8000的地址决定这里是cpu0的入口；
 *			可以通过将PC地址指向0x0000，4个CPU核都会从这里进入，这个地址的代码
 *			是复用的，会进入4次，在里面通过读寄存器判断进入的是哪个cpu。
 *			将MPIDR指示当前CPU id的值写入0x1000-0x4地址来主动进入cpu0，
 *			写入0x1000来进入cpu1，写入0x1004来进入cpu2，写入0x1008来进入cpu3，
 *			然后将该cpu的PC赋值为0x6000、0x4000、0x2000则能让几个cpu核都跑起来；
 *			但cpu1~3在这里先不使用。
 */
_start:
	/*
	 * \brief	从0x8000地址开始，每隔4字节的位置放一个中断处理函数，中断的顺序
	 *			是由BCM2836的ARM CPU和外设硬件已决定好的顺序。
	 * details	pc是程序执行的地址指针，当前是0x8000；ldr是将后面的地址赋值给
	 *			前面的寄存器；pc寄存器执行后会自动+4；
	 */
	ldr pc, reset_handler		@ 复位中断入口，CPU上电后首先执行的代码
	ldr pc, undefined_handler
	ldr pc, swi_handler
	ldr pc, prefetch_handler
	ldr pc, data_handler
	ldr pc, hyp_handler
	ldr pc, irq_handler
	ldr pc, fiq_handler
	@ 其它的中断暂时省略

/*
 * \brief	在reset_handler这个标号的地址放一个值，这个值是reset函数的入口
 * \details	reset这个函数在reset.S中定义，并会使用.globl输出符号，本文件里
 *			就能直接调用了
 */
reset_handler:		.word _reset

undefined_handler:	.word hang
swi_handler:		.word hang
prefetch_handler:	.word hang
data_handler:		.word hang
hyp_handler:		.word hang
irq_handler:		.word hang
fiq_handler:		.word hang

/*
 * \brief	死循环函数
 * \details	b是跳转指令
 *
hang: b hang
