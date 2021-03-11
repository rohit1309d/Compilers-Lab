	.file	"output.s"

.STR0:	.string "_____________ Calculating Force _____________\n"
.STR1:	.string "Input the value of mass:"
.STR2:	.string "Input the value of accelaration:"
.STR3:	.string "The value of force is "
.STR4:	.string "\n"
.STR5:	.string "\n__________________________\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$92, %rsp
# 0:
	movq	$.STR0,	%rdi
# 1:res = t000 
	pushq %rbp
	call	printStr
	movl	%eax, -16(%rbp)
	addq $8 , %rsp
# 2:
	movq	$.STR1,	%rdi
# 3:res = t001 
	pushq %rbp
	call	printStr
	movl	%eax, -20(%rbp)
	addq $8 , %rsp
# 4:res = t002 
	movl	$1, -28(%rbp)
# 5:res = err arg1 = t002 
	movl	-28(%rbp), %eax
	movl	%eax, -24(%rbp)
# 6:res = t003 arg1 = err 
	leaq	-24(%rbp), %rax
	movq	%rax, -36(%rbp)
# 7:res = t003 
# 8:res = t004 
	pushq %rbp
	movq	-36(%rbp), %rdi
	call	readInt
	movl	%eax, -40(%rbp)
	addq $0 , %rsp
# 9:res = mass arg1 = t004 
	movl	-40(%rbp), %eax
	movl	%eax, -8(%rbp)
# 10:res = t005 arg1 = t004 
	movl	-40(%rbp), %eax
	movl	%eax, -44(%rbp)
# 11:
	movq	$.STR2,	%rdi
# 12:res = t006 
	pushq %rbp
	call	printStr
	movl	%eax, -48(%rbp)
	addq $8 , %rsp
# 13:res = t007 arg1 = err 
	leaq	-24(%rbp), %rax
	movq	%rax, -56(%rbp)
# 14:res = t007 
# 15:res = t008 
	pushq %rbp
	movq	-56(%rbp), %rdi
	call	readInt
	movl	%eax, -60(%rbp)
	addq $0 , %rsp
# 16:res = accelaration arg1 = t008 
	movl	-60(%rbp), %eax
	movl	%eax, -12(%rbp)
# 17:res = t009 arg1 = t008 
	movl	-60(%rbp), %eax
	movl	%eax, -64(%rbp)
# 18:res = t010 arg1 = mass arg2 = accelaration 
	movl	-8(%rbp), %eax
	imull	-12(%rbp), %eax
	movl	%eax, -68(%rbp)
# 19:res = force arg1 = t010 
	movl	-68(%rbp), %eax
	movl	%eax, -4(%rbp)
# 20:res = t011 arg1 = t010 
	movl	-68(%rbp), %eax
	movl	%eax, -72(%rbp)
# 21:
	movq	$.STR3,	%rdi
# 22:res = t012 
	pushq %rbp
	call	printStr
	movl	%eax, -76(%rbp)
	addq $8 , %rsp
# 23:res = force 
# 24:res = t013 
	pushq %rbp
	movl	-4(%rbp) , %edi
	call	printInt
	movl	%eax, -80(%rbp)
	addq $0 , %rsp
# 25:
	movq	$.STR4,	%rdi
# 26:res = t014 
	pushq %rbp
	call	printStr
	movl	%eax, -84(%rbp)
	addq $8 , %rsp
# 27:
	movq	$.STR5,	%rdi
# 28:res = t015 
	pushq %rbp
	call	printStr
	movl	%eax, -88(%rbp)
	addq $8 , %rsp
# 29:res = t016 
	movl	$0, -92(%rbp)
# 30:res = t016 
	movl	-92(%rbp), %eax
	jmp	.LRT0
.LRT0:
	addq	$-92, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE0:
	.size	main, .-main
