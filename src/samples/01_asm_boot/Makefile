################################################################################
# File format: UTF-8
# 中文注释作者：将狼才鲸
# 注释增加日期：2022-11-20
################################################################################

# =  ?=  := 都是给变量赋值，只是含义不同
ARMGNU ?= arm-none-eabi

# 给变量赋值，这里的变量是gcc编译器的参数
COPS = -Wall -O2 -nostdinc -nostdlib -nostartfiles -ffreestanding 

##
# : 冒号前面的都是目标名，第一个目标是make命令时默认执行的目标
# 冒号后面是前面的目标要生成时需要依赖的目标；后面有目标的话则先找后面的目标
# 在哪里生成，处理要依赖的目标，依次递归，知道目标后面有具体的指令则执行指令
all : uart01.bin 

##
# clean是伪目标，一般用来执行shell命令删除编译后的文件；使用方法为make clean
clean :
	rm -f *.o
	rm -f *.elf
	rm -f *.list
	rm -f *.img

##
# 目标 : 被依赖的目标
# $()是引用标量
# 目标和依赖的目标单独成一行，第二行是要执行的命令，命令也是编译器的可执行文件名，后面是参数
# 命令必须是以tab打头，不能是空格；这里的命令是arm-none-eabi-as：编译汇编
# -o是生成编译后的中间文件
vectors.o : vectors.s
	$(ARMGNU)-as vectors.s -o vectors.o

# -c是指定要输入的文件，-o是指定要输出的文件
uart01.o : uart01.c
	$(ARMGNU)-gcc $(COPS) -c uart01.c -o uart01.o

periph.o : periph.c 
	$(ARMGNU)-gcc $(COPS) -c periph.c -o periph.o

##
# .list文件能查看各个变量的地址
# > 是Linux命中的重定向，将 > 前面的结果保存到 > 后面的文件中去
# -T是链接器加载链接配置
uart01.bin : loader.ld vectors.o periph.o uart01.o 
	$(ARMGNU)-ld vectors.o periph.o uart01.o -T loader.ld -o uart01.elf
	$(ARMGNU)-objdump -D uart01.elf > uart01.list
	$(ARMGNU)-objcopy uart01.elf -O binary kernel7.img

##
# 第0个串口不处理，第1个串口输入输出重定向到MSYS2的控制台
run:
	qemu-system-arm -M raspi2b -kernel kernel7.img -serial null -serial stdio
