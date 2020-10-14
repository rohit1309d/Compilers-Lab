	.file	"assgn1b.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"\nGCD of %d, %d, %d and %d is: %d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp     # pushing rbp into stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp  # copying rsp to rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp   # alloting memory to stack
	movl	$45, -20(%rbp)  #Mem[rbp-20] = 45
	movl	$99, -16(%rbp)  #Mem[rbp-16] = 99
	movl	$18, -12(%rbp)  # Mem[rbp-12] = 18
	movl	$180, -8(%rbp) # Mem[rbp-8] = 180
	movl	-8(%rbp), %ecx # ecx = Mem[rbp-8]
	movl	-12(%rbp), %edx # edx = Mem[rbp-12]
	movl	-16(%rbp), %esi # esi = Mem[rbp-16]
	movl	-20(%rbp), %eax  # eax = Mem[rbp-20]
	movl	%eax, %edi # edi = eax
	call	GCD4  # calling GCD4 function
	movl	%eax, -4(%rbp) # Mem[rbp-4] = eax
	movl	-4(%rbp), %edi # edi = Mem[rbp-4]
	movl	-8(%rbp), %esi # esi = Mem[rbp-8]
	movl	-12(%rbp), %ecx # ecx = Mem[rbp-12]
	movl	-16(%rbp), %edx # edx = Mem[rbp-16]
	movl	-20(%rbp), %eax # eax = Mem[rbp-20]
	movl	%edi, %r9d # r9d = edi
	movl	%esi, %r8d # esi = r8d
	movl	%eax, %esi # esi = eax
	leaq	.LC0(%rip), %rdi # copy address of .LC0 to rdi.
	movl	$0, %eax  # eax = 0
	call	printf@PLT # calling printf function
	movl	$10, %edi # edi = 10
	call	putchar@PLT  # calling putchar function
	movl	$0, %eax # eax = 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.globl	GCD4
	.type	GCD4, @function
GCD4:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp  # pushing rbp into stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp  # copying rsp to rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp  # alloting memory to stack
	movl	%edi, -20(%rbp) # Mem[rbp-20] = edi
	movl	%esi, -24(%rbp) # Mem[rbp-24] = esi
	movl	%edx, -28(%rbp) # Mem[rbp-28] = edx
	movl	%ecx, -32(%rbp) # Mem[rbp-32] = ecx
	movl	-24(%rbp), %edx # edx = Mem[rbp-24]
	movl	-20(%rbp), %eax # eax = Mem[rbp-20]
	movl	%edx, %esi  # esi = edx
	movl	%eax, %edi # edi = eax
	call	GCD  # calling GCD function
	movl	%eax, -12(%rbp) # Mem[rbp-12] = eax
	movl	-32(%rbp), %edx # edx = Mem[rbp-32]
	movl	-28(%rbp), %eax # eax = Mem[rbp-28]
	movl	%edx, %esi # esi = edx
	movl	%eax, %edi # edi = eax
	call	GCD # calling GCD function
	movl	%eax, -8(%rbp) # Mem[rbp-8] = eax
	movl	-8(%rbp), %edx # edx = Mem[rbp-8]
	movl	-12(%rbp), %eax # eax = Mem[rbp-12]
	movl	%edx, %esi # esi = edx
	movl	%eax, %edi # edi = eax
	call	GCD   # calling GCD function
	movl	%eax, -4(%rbp) # Mem[rbp-4] = eax
	movl	-4(%rbp), %eax  # eax = Mem[rbp-4]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	GCD4, .-GCD4
	.globl	GCD
	.type	GCD, @function
GCD:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp  # pushing rbp into stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp   # copying rsp to rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)  # Mem[rbp-20] = edi
	movl	%esi, -24(%rbp) # Mem[rbp-24] = esi
	jmp	.L6  # jump to .L6
.L7:
	movl	-20(%rbp), %eax # eax = Mem[rbp-20]
	cltd  #  converts the signed long in EAX to a signed double long in edx:eax
	idivl	-24(%rbp)  # divide operation
	movl	%edx, -4(%rbp) # Mem[rbp-4] = edx
	movl	-24(%rbp), %eax # eax = Mem[rbp-24]
	movl	%eax, -20(%rbp) # Mem[rbp-20] = eax
	movl	-4(%rbp), %eax # eax = Mem[rbp-4]
	movl	%eax, -24(%rbp) # Mem[rbp-24] = eax
.L6:
	movl	-20(%rbp), %eax # eax = Mem[rbp-20]
	cltd  #  converts the signed long in EAX to a signed double long in edx:eax
	idivl	-24(%rbp)  # divide operation
	movl	%edx, %eax # eax = edx
	testl	%eax, %eax # set SF to 1 if eax < 0
	jne	.L7  # jump to .L7 if SF != 1
	movl	-24(%rbp), %eax # eax = Mem[rbp-24]
	popq	%rbp # pop rbp from stack
	.cfi_def_cfa 7, 8
	ret  # return eax value
	.cfi_endproc
.LFE2:
	.size	GCD, .-GCD
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
