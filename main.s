	.include "gpio.inc" @ Includes definitions from gpio.inc file

	.thumb              @ Assembles using thumb mode
	.cpu cortex-m3      @ Generates Cortex-M3 instructions
	.syntax unified

	.include "nvic.inc"

delay:
		push	{r7}
		sub		sp, sp, #20
		add		r7, sp, #0
		str		r0, [r7, #4]
		movs	r3, #0
		str		r3, [r7, #12]
		b		.L2
.L5:
		movs	r3, #0
		str		r3, [r7, #8]
		b		.L3
.L4:
		ldr 	r3, [r7, #8]
		adds	r3, r3, #1
		str		r3, [r7, #8]
.L3:
		ldr		r3, [r7, #8]
		cmp		r3, #254
		ble		.L4
		ldr		r3, [r7, #12]
		adds	r3, r3, #1
		str		r3, [r7, #12]
.L2:
		ldr		r1, [r7, #12]
		ldr		r3, [r7, #4]
		cmp		r1, r3
		blt		.L5
		nop
		nop
		adds	r7, r7, #20
		mov		sp, r7
		pop 	{r7}
		bx		lr

setup:
        @ enabling clock in port A, B and C
        ldr     r0, =RCC_APB2ENR
        mov     r3, 0x1C 
        str     r3, [r0]

		@ set pins PB5 - PB7 as digital output
        ldr     r0, =GPIOB_CRL
        ldr     r3, =0x33344444
        str     r3, [r0]

		@ set pins PB8 - PB15 as digital output
        ldr     r0, =GPIOB_CRH
        ldr     r3, =0x33333333
        str     r3, [r0]

        @ set pins PA0 and PA4 as digital input
        ldr     r0, =GPIOA_CRL
        ldr     r3, =0x44484448
        str     r3, [r0]

        # set led status initial value
		ldr     r7, =GPIOB_ODR
		mov		r4, 0x0
		str		r4, [r7]

		mov		r2, 0x0
loop:
		@ Check if both, A0 and A4 are pressed at the same time
		ldr		r0, =GPIOA_IDR
		ldr 	r1, [r0]
		and		r1, r1, 0x11
		cmp		r1, 0x11
		beq		reset_count
		mov		r0, #700    
		bl   	delay
	
    	@ Continue reading if any of them are pressed
		@ Check if A0 is pressed
    	ldr 	r0, =GPIOA_IDR
    	ldr 	r1, [r0]
    	and 	r1, r1, 0x01
    	cmp 	r1, 0x0
    	beq 	.L6     
		mov		r0, r2
		bl 		inc_count
		mov		r2, r0

.L6:		
    	@ Check if A4 is pressed
    	ldr 	r0, =GPIOA_IDR
    	ldr 	r1, [r0]
    	and 	r1, r1, 0x10
    	cmp 	r1, 0x0
    	beq 	.L7
		mov		r0, r2
		bl		dec_count
		mov		r2, r0

.L7:
		b 		loop

inc_count:
    	@ Increase counter
		push 	{r7, lr}
		sub 	sp, sp, #8
		add		r7, sp, #0
		str		r0, [r7, #4]
		ldr		r0, [r7, #4]
    	adds	r0, r0, #1
		str		r0, [r7, #4]
		ldr		r3, =0x3FF
    	cmp 	r0, r3
    	bgt 	reset_count   @ Jumps to "reset_count" if counter value is grather than 1023
    
    	@ Turn LEDs on
    	ldr 	r3, =GPIOB_ODR
		mov 	r1, r0
		mov		r4, r0
		lsl 	r1, r1, #5
    	str 	r1, [r3]
		mov		r0, #500    
		bl   	delay
		mov		r0, r4
		adds	r7, r7, #8
		mov		sp, r7
		pop 	{r7}
		pop		{lr}
		bx		lr

dec_count:
	   	@ Decrease counter
		push 	{r7, lr}
		sub 	sp, sp, #8
		add		r7, sp, #0
		str		r0, [r7, #4]
		ldr		r0, [r7, #4]
    	sub 	r0, r0, #1
		str		r0, [r7, #4]
    	cmp 	r0, #0
    	blt 	reset_count   @ Jumps to "reset_count" if counter value is less than 0

		@ Turn LEDs on
		ldr 	r3, =GPIOB_ODR
		ldr		r0, [r7, #4]
		mov 	r1, r0
		mov		r4, r0
		lsl 	r1, r1, #5
		str 	r1, [r3]
		mov		r0, #500    
		bl   	delay
		mov		r0, r4
		adds	r7, r7, #8
		mov		sp, r7
		pop 	{r7}
		pop		{lr}
		bx		lr

reset_count:
		@ Turn LEDs off
		ldr 	r0, =GPIOB_ODR
		mov 	r1, 0x0
		mov 	r2, r1
		str 	r1, [r0]
		mov		r0, #500    
		bl   	delay
		b		loop