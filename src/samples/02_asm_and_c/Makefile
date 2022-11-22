################################################################################
# \brief	编译配置文件
# \note		File format: UTF-8
# \author	将狼才鲸
# \date		2022-11-20
################################################################################

##
# ?= 给前面的变量赋值，如果变量没有被赋过值，才会进行赋值
# CROSS_COMPILE是从Linux kernel的Makefile中抄来的名字，用什么名字都可以，这里
#	用来指示交叉编译器的前缀
CROSS_COMPILE ?= arm-none-eabi-

##
# = 给前面的变量赋值，但是会在整个Makefile文件统一展开变量时，才真正给这个变量赋值，
#	即使在赋值的这行语句前面引用了CFLAGS这个变量，这个变量在前面展开的值也会是最后面
#	= 所赋的值；也就是后面的=号赋值能影响前面已经被调用过的变量。
# CFLAGS这个变量名是约定俗成的gcc的参数值
#	具体的参数值的含义可自行搜索
CFLAGS = -Wall -O2 -ffreestanding -nostartfiles

##
# : 前面的是目标，: 后面是依赖的目标或者依赖的要处理的文件，
#	这里的all目标是伪目标，代表执行: 冒号后面的目标
# 第一个标签是直接敲make命令时默认执行的目标
all: clean kernel7.img

##
# 这里先不用文件夹包含和自动依赖，而是对每个文件指定具体的路径，后面的工程
#	会写通用的Makefile
##

##
# 如果目标和依赖项的下一行是以tab开头的，代表是要执行的命令，该命令的输入参数
#	就是依赖项中所列出的文件；命令必须以tab开头，不能以空格开头
# 具体gcc软件的参数的含义可自行搜索
# 有多个目标要执行时，要生成的文件不必按照编译的顺序，前面的目标生成时如果发现
#	缺少依赖项，会自动的往后寻找，并先编译要依赖的目标
kernel7.img: main.o reset.o vectors.o ../../arch/bcm2836/boot/link.ld
	$(CROSS_COMPILE)ld vectors.o reset.o main.o -T ../../arch/bcm2836/boot/link.ld -o kernel7.elf
	$(CROSS_COMPILE)objcopy -O binary kernel7.elf kernel7.img

main.o: main.c
	$(CROSS_COMPILE)gcc $(CFLAGS) -c main.c -o main.o

reset.o: ../../arch/bcm2836/boot/reset.S
	$(CROSS_COMPILE)as ../../arch/bcm2836/boot/reset.S -o reset.o

vectors.o: ../../arch/bcm2836/boot/vectors.S
	$(CROSS_COMPILE)as ../../arch/bcm2836/boot/vectors.S -o vectors.o

##
# clean是伪目标，清理编译生成的文件
# > 是linux管道的命令，这里是让没有*.elf *.o文件时，报错信息输出到别的地方，不从终端显示
clean:
	rm kernel7.elf *.o >/dev/null 2>/dev/null || true

# run也是伪目标，直接运行程序
run:
	qemu-system-arm -M raspi2b -kernel kernel7.img -serial null -serial stdio
