	.thumb
	.syntax unified
	.section .text
vectors:
	.word zhanding
	.word kaishi + 1
	.word _nmi	+1
	.word _Hard_Fault +1
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word _svc_handler +1
	.word 0
	.word 0
	.word _pendsv_handler +1
	.word _systickzhongduan +1  @ 15
	.word aaa +1                @ 0
	.word aaa +1                @ 1
	.word aaa +1                @ 2
	.word aaa +1                @ 3
	.word aaa +1                @ 4
	.word aaa +1         	    @ 5
	.word aaa +1                @ 6
	.word aaa +1                @ 7
	.word aaa +1                @ 8
	.word aaa +1                @ 9
	.word aaa +1                @ 10
	.word aaa +1                @ 11
	.word aaa +1                @ 12
	.word aaa +1                @ 13
	.word aaa +1                @ 14
	.word aaa +1                @ 15
	.word aaa +1                @ 16
	.word aaa +1                @ 17
	.word aaa +1                @ 18
	.word aaa +1                @ 19
	.word aaa +1                @ 20
	.word aaa +1                @ 21
	.word aaa +1                @ 22
	.word aaa +1                @ 23
	.word aaa +1                @ 24
	.word aaa +1                @ 25
	.word aaa +1                @ 26
	.word aaa +1                @ 27
	.word aaa +1		    @ 28
	.word aaa +1		    @ 29
	.word aaa +1		    @ 30
	.word aaa +1		    @ 31
kaishi:
@	bkpt # 1

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@IO设置@
	@0x40040000+0x20*m(0-9)
	@0X00=PCNTR1/PODR (0=输入，1=输出)
	@0x02=PDR (0=输出低，1=输出高)
	@0x04=PCNTR2/EIDR (输入状态：0=低，1=高)
	@0x06=PIDR (ECL_PORT端口事件输入数据：0=低，1=高)
	@0x08=PCNTR3/PORR (0=不影响别的位，1=高)
	@0x0a=POSR (0不影响别的位，1=低)
	@0x0c=PCNTR4/EORR (ELC_PORT: 0=不影响别的端口，1=高)
	@0x0e=EOSR	(ELC_PORT:0不影响别的端口，1=低)
	@PFS = 0x4004_0800
	@0x000 + 0x040 × m + 0x004 × n (PmnPFS)
	@0x002 + 0x040 × m + 0x004 × n (PmnPFS_HA)
	@0x003 + 0x040 × m + 0x004 × n (PmnPFS_)
	@P108、P201、P300的初始值不为0x00000000
	@P108初始值为0x00010010
	@P201初始值为0x00000010
	@P201初始值为0x00000010
	@P300为0x00010010
	@位0=端口输出数据（0=低，1=高），位1=PIDR状态（0=低，1=高）
	@位2=端口方向（1=输入，0=输出），位4=拉（0=禁输入上拉，1=输入上拉）
	@位6=开漏（0=CMOS输出，1=NMOS开漏输出）
	@位12-13上下事件（00=不关心，01=检测上升，10=检测下降）
	@位14 IRQ（0不作为IRQ输入引脚，1作为IRQ输入引脚）
	@位15 模拟功能（0=不作为模拟引脚，1=作为模拟引脚）
	@位16复用（0=作为通用IO，1=作为外设IO）
	@位24-28 外设选择
	@写保护=0x40040800+0x503
	@位6（0=禁止写PmnPFS寄存器，1=使能写PmnPFS寄存器）
	@位7（0=使能写PFSWE位，1=禁止写PFSWE位）
	@端口读取等待控制=0x40040800+0x50f
	@位0-1（00=设置禁止,01=插入1周期等待)
	@      (02=插入2周期等待,03=插入3周期等待）
	ldr r0, = 0x40040000
	ldr r1, = 0x01
	strh r1, [r0, # 0x02]
	movs r1, # 0x01
	strh r1, [r0, # 0x0a]
	


	
ting:
	ldr r0, = 0x40040000
	movs r1, # 0x01
	ldr r2, = 0xffff
	strh r1, [r0, # 0x0a]
__led_kai_yanshi:
	subs r2, r2, # 1
	bne __led_kai_yanshi
	strh r1, [r0, # 0x08]
	ldr r2, = 0x1ffff
__led_guan_yanshi:
	subs r2, r2, # 1
	bne __led_guan_yanshi
	b ting
_nmi:
_Hard_Fault:
_svc_handler:
_pendsv_handler:	
_systickzhongduan:
aaa:
	bx lr
	
	.section .data
	.equ zhanding,	0x20004100
	
