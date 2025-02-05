;;
; File format: UTF-8
; 原始代码来自于 https://gitee.com/mirrors_dwelch67/raspberrypi/tree/master/boards/pi2/SVC_BOOT/uart01
; 或者https://github.com/dwelch67/raspberrypi/tree/master/boards/pi2/SVC_BOOT/uart01
;;

See the top level README for information on where to find documentation
for the raspberry pi and the ARM processor inside.  Also find information
on how to load and run these programs.

This example is for the pi2, see other directories for other flavors
of raspberry pi.

Investigating/confirming what other folks have already found.

The MPIDR for the four cores are

80000F00
80000F01
80000F02
80000F03

We can use the lower nibble to sort them on boot (they all start
presumably at the same time, at the same entry point).

This config.txt is required in the same root directory where kernel7.img
lives.

kernel_old=1
disable_commandline_tags=1

The first line tells the start.elf bootloader to not boot from 0x8000
but instead from 0x0000, the second line says please do not trash
the first few hundred bytes with ATAG or device tree information.
Without that second line it loads kernel7.img then writes the ATAG
information assuming you have left a gap and branched over.
