# GPIO settings

.equ GPIOA_CRL, 0x40010800  @ General-purpose I/O config. register port(0-7)
.equ GPIOA_CRH, 0x40010804  @ General-purpose I/O config. register port(8-F)
.equ GPIOA_IDR, 0x40010808  @ Port input data register offset
.equ GPIOA_ODR, 0x4001080C  @ Port output data register offset

.equ GPIOB_CRL, 0x40010C00  @ General-purpose I/O config. register port(0-7)
.equ GPIOB_CRH, 0x40010C04  @ General-purpose I/O config. register port(8-F)
.equ GPIOB_IDR, 0x40010C08  @ Port input data register offset
.equ GPIOB_ODR, 0x40010C0C  @ Port output data register offset

.equ GPIOC_CRL, 0x40011000  @ General-purpose I/O config. register port(0-7)
.equ GPIOC_CRH, 0x40011004  @ General-purpose I/O config. register port(8-F)
.equ GPIOC_IDR, 0x40011008  @ Port input data register offset
.equ GPIOC_ODR, 0x4001100C  @ Port output data register offset

.equ GPIOD_CRL, 0x40011400  @ General-purpose I/O config. register port(0-7)
.equ GPIOD_CRH, 0x40011404  @ General-purpose I/O config. register port(8-F)
.equ GPIOD_IDR, 0x40011408  @ Port input data register offset
.equ GPIOD_ODR, 0x4001140C  @ Port output data register offset

.equ GPIOE_CRL, 0x40011800  @ General-purpose I/O config. register port(0-7)
.equ GPIOE_CRH, 0x40011804  @ General-purpose I/O config. register port(8-F)
.equ GPIOE_IDR, 0x40011808  @ Port input data register offset
.equ GPIOE_ODR, 0x4001180C  @ Port output data register offset

.equ GPIOF_CRL, 0x40011C00  @ General-purpose I/O config. register port(0-7)
.equ GPIOF_CRH, 0x40011C04  @ General-purpose I/O config. register port(8-F)
.equ GPIOF_IDR, 0x40011C08  @ Port input data register offset
.equ GPIOF_ODR, 0x40011C0C  @ Port output data register offset

.equ GPIOG_CRL, 0x40012000  @ General-purpose I/O config. register port(0-7)
.equ GPIOG_CRH, 0x40012004  @ General-purpose I/O config. register port(8-F)
.equ GPIOG_IDR, 0x40012008  @ Port input data register offset
.equ GPIOG_ODR, 0x4001200C  @ Port output data register offset



# RCC settings
.equ RCC_BASE,     0x40021000
.equ RCC_APB2ENR,  0x40021018
