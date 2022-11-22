/**
 * \brief	链接器脚本文件
 * \details	描述内存怎么分布，代码段怎么分布等
 * \note	File format: UTF-8
 * \author	注释作者：将狼才鲸
 * \date	注释日期：2022-11-20
 * \note	参考网址：
 *			[GNU链接脚本详解](https://zhuanlan.zhihu.com/p/516338675)
 *			[浅谈RISC-V GCC之：链接脚本学习笔记(一)]
 *			(https://blog.csdn.net/qq_36353650/article/details/121157530)
 *			[浅谈text段、data段和bss段](https://blog.csdn.net/thisway_diy/article/details/77450537)
 *			[定位符号‘.’的使用](https://www.cnblogs.com/dream397/p/15775303.html)
 * \note	如果链接时没有指定脚本文件，则链接器会使用默认脚本
 */

/*
 * \brief	存储器、内存等空间配置命令
 */
MEMORY
{
	/* 指定内存的起始地址和长度 */
    ram : ORIGIN = 0x0000, LENGTH = 0x1000000
}

/*
 * \brief	代码段等段布局
 */
SECTIONS
{
	/* 只读代码段，将所有目标文件的text段放入到内存中，*(.text*)能匹配到所有代码段文件 */
    .text : { *(.text*) } > ram
	/* 程序未初始化的全局变量 */
    .bss : { *(.bss*) } > ram
}
