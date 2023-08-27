	@ADC例子	
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
	.word 0
	.word _svc_handler +1
	.word 0
	.word 0
	.word _pendsv_handler +1
	.word _systickzhongduan +1  @ 15
	.word __adc120_adi +1                @ 0
	.word aaa +1	            @ 1
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
	@bkpt # 1
shizhong:
	ldr r0, = 0x4001e000
	movw r2, # 0x3fe
	movw r1, # 0xa501
	strh r1, [r0, r2]	@解锁时钟配置寄存器
	movs r1, # 0
	strh r1, [r0, # 0x32]	@主时钟开
__deng_zhu_shi_zhong_wen_ding:
	ldr r1, [r0, # 0x3c]
	lsls r1, r1, # 28
	bpl __deng_zhu_shi_zhong_wen_ding
	movs r1, # 0x03
	strh r1, [r0, # 0x26]	@主时钟作为时钟源
	movs r1, # 0
	str r1, [r0, # 0x20]

_neicunqingling:
	ldr r0, = 0x20005000
	ldr r2, = 0x20004000
	movs r1, # 0
_neicunqinglingxunhuan:
	subs r0, r0, # 4
	str r1, [r0]
	cmp r0, r2
	bne _neicunqinglingxunhuan

	
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
	movs r1, #  0x01
	strh r1, [r0, # 0x02]
	movs r1, # 0x01
	strh r1, [r0, # 0x0a]
	
	ldr r3, = 0x40040800
	movw r2, # 0x503
	movs r1, # 0
	strb r1, [r3, r2]
	movs r1, # 0x40
	strb r1, [r3, r2]
	
	movw r2, # 0x100
	adds r2, r2, r3
	ldr r1, = 0x3010000
	str r1, [r2]


__mo_kuai_kong_zhi:			@外设模块开关
	ldr r0, = 0x4001e3fe
	ldr r1, = 0xa503
	strh r1, [r0]
	ldr r0, = 0x40047000
	ldr r1, = 0xfffebfbf
	str r1, [r0, # 0x08]
	ldr r1, = 0xffffbfff
	str r1, [r0, # 0x04]
	ldr r0, = 0x4001e000
	ldr r1, = 0xffbfffff
	str r1, [r0]		@开DTC模块
	

@__systick_zhongduan:
@	ldr r0, = 0xe000e010
@	ldr r1, = 199999
@	str r1, [r0, # 4]
@	str r1, [r0, # 8]
@	movs r1, # 0x07
@	str r1, [r0]    @systick 开

__kai_nvic_iser:
	ldr r0, = 0xe000e100
	ldr r1, =  1
	str r1, [r0]

__adc_shezhi:
	ldr r0, = 0x4005c000
	movw r1, # 0x100
	strh r1, [r0, # 0x12]
	movw r1, # 0x6040
	strh r1, [r0]
	movw r1, # 0xe000
	strh r1, [r0]
	
	bkpt # 3
__icu_dtc:
	ldr r1, = 0x20004000
	ldr r2, = 0x400
	str r2, [r1, # 0x04]	@传输源
	ldr r2, = 0x20005000
	str r2, [r1, # 0x08]	@传输目的地
	movw r2, # 0xff00
	strh r2, [r1, # 0x0e]	@传输数量
	movs r2, # 0x50
	strb r2, [r1, # 0x03]	@MRA
	movs r2, # 0x08
	strb r2, [r1, # 0x02]	@MRB
	
        ldr r0, = 0x40005400
	str r1, [r0, # 0x04]    @DTCVBR
	movs r1, # 0x08
	strb r1, [r0]

	ldr r2, = 0x40006300
	ldr r1, = 0x1000007     @DTC
	str r1, [r2]

	movs r1, # 0x01
	strb r1, [r0, # 0x0c]	@开DTC
	

	
__gpt_shezhi:				@定时器初始化
	ldr r0, = 0x40078900	@GPT，4=0X400到9=0X900
	movw r1, # 0xa500
	strh r1, [r0]
	movw r1, # 0x200
	str r1, [r0, # 0x04]	@开GPT,0、4-9
	movs r1, # 0x01
	str r1, [r0, # 0x2c]
	movw r1, # 0x103
	str r1, [r0, # 0x34]	@GTIOR 通用PWM定时器IO控制寄存器
	ldr r1, = 1
	str r1, [r0, # 0x4c]	@GTCRK捕获比较
				@0X4C，0X50，0X54，0X58，0X5C，0X60

	ldr r1, = 9999
	str r1, [r0, # 0x64]	@GTPR	定时器最大计数值

	
ting:
	ldr r0, = 0x40040000
	movs r1, # 0x01
	ldr r2, = 0xfffff
	strh r1, [r0, # 0x0a]
__led_kai_yanshi:
	subs r2, r2, # 1
	bne __led_kai_yanshi
	strh r1, [r0, # 0x08]
	ldr r2, = 0xfffff
__led_guan_yanshi:
	subs r2, r2, # 1
	bne __led_guan_yanshi
	b ting
_nmi:
_Hard_Fault:
_svc_handler:
_pendsv_handler:	
_systickzhongduan:
__systick_fanhui:
	ldr r0, = 0xe0000d04
	ldr r1, = 0x02000000
	str r1, [r0]                 @ 清除SYSTICK中断
	bx lr
	
__adc120_adi:
a:
	movs r0, r0
	b  a
	ldr r2, = 0x40006300
	ldr r1, = 0x07     @DTC
	str r1, [r2]
	ldr r1, = 0x1000007
	str r1, [r2]
	
	bx lr
aaa:	
	b aaa
	bkpt # 88
	bx lr
	
	.section .data
	.equ zhanding,	0x20004100
	
