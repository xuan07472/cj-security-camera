;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; \brief	汇编boot文件
; \note		File format: UTF-8
; \author	注释作者：将狼才鲸
; \date		注释日期：2022-11-20
; \note		参考网址：
;			[常见的GNU汇编伪指令](https://blog.csdn.net/oqqHuTu12345678/article/details/125694068)
;			[Using as The gnu Assembler] GNU官方文档的“7.59 .space size , fill”小节
;			[协处理器CP15介绍—MCR/MRC指令](https://blog.csdn.net/daocaokafei/article/details/114292514)
;			[DUI0588B_assembler_reference.pdf] ARM官方文档的“3.58 MRC, MRC2, MRRC and MRRC2”
;			[DDI0464F_cortex_a7_mpcore_r0p5_trm.pdf] ARM官方文档的“4.2.1 c0 registers”和4.3.1 Main ID Register
;			[ARM数据处理指令——逻辑运算指令](https://www.csdn.net/tags/NtDakg0sNTMyMzUtYmxvZwO0O0OO0O0O.html)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; 给_start一个外部链接属性，类似于C语言的extern
.globl _start	; _start是一个系统默认的起始函数名

; 冒号前的是标号，也是函数名
_start:
    b skip				; 跳转到skip函数

; 将当前区域的0x1000-0x4长度的内容用0填充
.space 0x1000-0x4,0

;;
; \brief 名为skip的函数，
skip:
	; 判断芯片的型号，是ARMv6的树莓派1，还是ARMv7的树莓派2，还是ARMv8的树莓派3
	; 第一个参数固定为p15，协处理器的固定操作码0，第三个ARM寄存器，第四个CP15协处理器寄存器，协处理器附加寄存器，协处理器操作码
    mrc p15,0,r0,c0,c0,5	; 5操作码指的是MPIDR ; CP15存储类协处理器读数据到ARM CPU，获取Aliases of Main ID Register
    mov r1,#0xFF			; r1 = 0xFF
    ands r1,r1,r0			; r1 = r1 & r0
    bne not_zero

    mov sp,#0x8000
    bl notmain
hang: b hang

not_zero:
    cmp r1,#1
    beq core_one
    cmp r1,#2
    beq core_two
    cmp r1,#3
    beq core_three
    b .

core_one:
ldr r1,=0x1000
str r0,[r1]
    mov sp,#0x6000
    mov r1,#0
    str r1,[sp]
core_one_loop:
    ldr r0,[sp]
    cmp r0,#0
    beq core_one_loop
    bl hopper
    b hang

core_two:
ldr r1,=0x1004
str r0,[r1]
    mov sp,#0x4000
    mov r1,#0
    str r1,[sp]
core_two_loop:
    ldr r0,[sp]
    cmp r0,#0
    beq core_two_loop
    bl hopper
    b hang

core_three:
ldr r1,=0x1008
str r0,[r1]
    mov sp,#0x2000
    mov r1,#0
    str r1,[sp]
core_three_loop:
    ldr r0,[sp]
    cmp r0,#0
    beq core_three_loop
    bl hopper
    b hang

hopper:
    bx r0


.globl PUT32
PUT32:
    str r1,[r0]
    bx lr

.globl PUT16
PUT16:
    strh r1,[r0]
    bx lr

.globl PUT8
PUT8:
    strb r1,[r0]
    bx lr

.globl GET32
GET32:
    ldr r0,[r0]
    bx lr

.globl GETPC
GETPC:
    mov r0,lr
    bx lr

.globl BRANCHTO
BRANCHTO:
    mov r12,#0
    mcr p15, 0, r12, c7, c10, 1
    dsb
    mov r12, #0
    mcr p15, 0, r12, c7, c5, 0
    mov r12, #0
    mcr p15, 0, r12, c7, c5, 6
    dsb
    isb
    bx r0

.globl dummy
dummy:
    bx lr

.globl GETCPSR
GETCPSR:
    mrs r0,cpsr
    bx lr

.globl GETSCTLR
GETSCTLR:
    mrc p15,0,r0,c1,c0,0
    bx lr

.globl GETMPIDR
GETMPIDR:
    mrc p15,0,r0,c0,c0,5 ;@ MPIDR
    bx lr


;@-------------------------------------------------------------------------
;@-------------------------------------------------------------------------


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
