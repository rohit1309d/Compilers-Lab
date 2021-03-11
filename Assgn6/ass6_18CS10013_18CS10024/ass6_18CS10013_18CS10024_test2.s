	.file	"output.s"

.STR0:	.string "_____________ Convert Decimal Number to Binary ______________\n"
.STR1:	.string "Input an integer : "
.STR2:	.string "The binary representation of the integer is:"
.STR3:	.string "\n"
.STR4:	.string "\n_______________________________________________\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$470, %rsp
# 0:res = t000 
	movl	$100, -112(%rbp)
# 1:res = t001 
	movl	$100, -216(%rbp)
# 2:res = t002 
	movl	$1, -224(%rbp)
# 3:res = i arg1 = t002 
	movl	-224(%rbp), %eax
	movl	%eax, -220(%rbp)
# 4:res = t003 arg1 = t002 
	movl	-224(%rbp), %eax
	movl	%eax, -228(%rbp)
# 5:res = t004 
.L3:
	movl	$100, -232(%rbp)
# 6:arg1 = i arg2 = t004 
	movl	-220(%rbp), %eax
	movl	-232(%rbp), %edx
	cmpl	%edx, %eax
	jle .L1
# 7:
	jmp .L2
# 8:
	jmp .L2
# 9:res = t005 arg1 = i 
.L4:
	movl	-220(%rbp), %eax
	movl	%eax, -236(%rbp)
# 10:res = i arg1 = i 
	movl	-220(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -220(%rbp)
# 11:
	jmp .L3
# 12:res = t006 
.L1:
	movl	$0, -240(%rbp)
# 13:res = t007 
	movl	$1, -244(%rbp)
# 14:res = t008 arg1 = i arg2 = t007 
	movl	-220(%rbp), %eax
	movl	-244(%rbp), %edx
	subl	%edx, %eax
	movl	%eax, -248(%rbp)
# 15:res = t010 arg1 = t008 
	movl	-248(%rbp), %eax
	movl	$1, %ecx
	imull	%ecx, %eax
	movl	%eax, -256(%rbp)
# 16:res = t009 arg1 = t006 arg2 = t010 
	movl	-240(%rbp), %eax
	movl	-256(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -252(%rbp)
# 17:res = t011 
	movl	$0, -260(%rbp)
# 18:res = t012 arg1 = t011 
# 19:res = binaryN arg1 = t009 arg2 = t012 
	leaq	-108(%rbp), %rdx
	movslq	-252(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-261(%rbp), %eax
	movb	%al, (%rdx)
# 20:res = t013 arg1 = t012 
	movzbl	-261(%rbp), %eax
	movb	%al, -262(%rbp)
# 21:res = t014 
	movl	$0, -266(%rbp)
# 22:res = t015 
	movl	$1, -270(%rbp)
# 23:res = t016 arg1 = i arg2 = t015 
	movl	-220(%rbp), %eax
	movl	-270(%rbp), %edx
	subl	%edx, %eax
	movl	%eax, -274(%rbp)
# 24:res = t018 arg1 = t016 
	movl	-274(%rbp), %eax
	movl	$1, %ecx
	imull	%ecx, %eax
	movl	%eax, -282(%rbp)
# 25:res = t017 arg1 = t014 arg2 = t018 
	movl	-266(%rbp), %eax
	movl	-282(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -278(%rbp)
# 26:res = t019 
	movl	$0, -286(%rbp)
# 27:res = t020 arg1 = t019 
# 28:res = reverseBinaryN arg1 = t017 arg2 = t020 
	leaq	-212(%rbp), %rdx
	movslq	-278(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-287(%rbp), %eax
	movb	%al, (%rdx)
# 29:res = t021 arg1 = t020 
	movzbl	-287(%rbp), %eax
	movb	%al, -288(%rbp)
# 30:
	jmp .L4
# 31:
.L2:
	movq	$.STR0,	%rdi
# 32:res = t022 
	pushq %rbp
	call	printStr
	movl	%eax, -292(%rbp)
	addq $8 , %rsp
# 33:
	movq	$.STR1,	%rdi
# 34:res = t023 
	pushq %rbp
	call	printStr
	movl	%eax, -296(%rbp)
	addq $8 , %rsp
# 35:res = t024 
	movl	$1, -304(%rbp)
# 36:res = err arg1 = t024 
	movl	-304(%rbp), %eax
	movl	%eax, -300(%rbp)
# 37:res = t025 arg1 = err 
	leaq	-300(%rbp), %rax
	movq	%rax, -312(%rbp)
# 38:res = t025 
# 39:res = t026 
	pushq %rbp
	movq	-312(%rbp), %rdi
	call	readInt
	movl	%eax, -316(%rbp)
	addq $0 , %rsp
# 40:res = N arg1 = t026 
	movl	-316(%rbp), %eax
	movl	%eax, -4(%rbp)
# 41:res = t027 arg1 = t026 
	movl	-316(%rbp), %eax
	movl	%eax, -320(%rbp)
# 42:res = tempN arg1 = N 
	movl	-4(%rbp), %eax
	movl	%eax, -8(%rbp)
# 43:res = t028 arg1 = N 
	movl	-4(%rbp), %eax
	movl	%eax, -324(%rbp)
# 44:res = t029 
	movl	$0, -332(%rbp)
# 45:res = j arg1 = t029 
	movl	-332(%rbp), %eax
	movl	%eax, -328(%rbp)
# 46:res = t030 
.L10:
	movl	$0, -336(%rbp)
# 47:arg1 = tempN arg2 = t030 
	movl	-8(%rbp), %eax
	movl	-336(%rbp), %edx
	cmpl	%edx, %eax
	jne .L5
# 48:
	jmp .L6
# 49:
	jmp .L6
# 50:res = t031 
.L5:
	movl	$2, -340(%rbp)
# 51:res = t032 arg1 = tempN arg2 = t031 
	movl	-8(%rbp), %eax
	cltd
	idivl	-340(%rbp), %eax
	movl	%edx, -344(%rbp)
# 52:res = t033 
	movl	$1, -348(%rbp)
# 53:arg1 = t032 arg2 = t033 
	movl	-344(%rbp), %eax
	movl	-348(%rbp), %edx
	cmpl	%edx, %eax
	je .L7
# 54:
	jmp .L8
# 55:
	jmp .L9
# 56:res = t034 
.L7:
	movl	$0, -352(%rbp)
# 57:res = t036 arg1 = j 
	movl	-328(%rbp), %eax
	movl	$1, %ecx
	imull	%ecx, %eax
	movl	%eax, -360(%rbp)
# 58:res = t035 arg1 = t034 arg2 = t036 
	movl	-352(%rbp), %eax
	movl	-360(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -356(%rbp)
# 59:res = t037 
	movb	$49, -361(%rbp)
# 60:res = reverseBinaryN arg1 = t035 arg2 = t037 
	leaq	-212(%rbp), %rdx
	movslq	-356(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-361(%rbp), %eax
	movb	%al, (%rdx)
# 61:res = t038 arg1 = t037 
	movzbl	-361(%rbp), %eax
	movb	%al, -362(%rbp)
# 62:
	jmp .L9
# 63:res = t039 
.L8:
	movl	$0, -366(%rbp)
# 64:res = t041 arg1 = j 
	movl	-328(%rbp), %eax
	movl	$1, %ecx
	imull	%ecx, %eax
	movl	%eax, -374(%rbp)
# 65:res = t040 arg1 = t039 arg2 = t041 
	movl	-366(%rbp), %eax
	movl	-374(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -370(%rbp)
# 66:res = t042 
	movb	$48, -375(%rbp)
# 67:res = reverseBinaryN arg1 = t040 arg2 = t042 
	leaq	-212(%rbp), %rdx
	movslq	-370(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-375(%rbp), %eax
	movb	%al, (%rdx)
# 68:res = t043 arg1 = t042 
	movzbl	-375(%rbp), %eax
	movb	%al, -376(%rbp)
# 69:
	jmp .L9
# 70:res = t044 arg1 = j 
.L9:
	movl	-328(%rbp), %eax
	movl	%eax, -380(%rbp)
# 71:res = j arg1 = j 
	movl	-328(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -328(%rbp)
# 72:res = t045 
	movl	$2, -384(%rbp)
# 73:res = t046 arg1 = tempN arg2 = t045 
	movl	-8(%rbp), %eax
	cltd
	idivl	-384(%rbp), %eax
	movl	%eax, -388(%rbp)
# 74:res = tempN arg1 = t046 
	movl	-388(%rbp), %eax
	movl	%eax, -8(%rbp)
# 75:res = t047 arg1 = t046 
	movl	-388(%rbp), %eax
	movl	%eax, -392(%rbp)
# 76:
	jmp .L10
# 77:res = t048 
.L6:
	movl	$0, -396(%rbp)
# 78:res = i arg1 = t048 
	movl	-396(%rbp), %eax
	movl	%eax, -220(%rbp)
# 79:res = t049 arg1 = t048 
	movl	-396(%rbp), %eax
	movl	%eax, -400(%rbp)
# 80:res = t050 
.L13:
	movl	$0, -404(%rbp)
# 81:arg1 = j arg2 = t050 
	movl	-328(%rbp), %eax
	movl	-404(%rbp), %edx
	cmpl	%edx, %eax
	jg .L11
# 82:
	jmp .L12
# 83:
	jmp .L12
# 84:res = t051 
.L11:
	movl	$0, -408(%rbp)
# 85:res = t053 arg1 = i 
	movl	-220(%rbp), %eax
	movl	$1, %ecx
	imull	%ecx, %eax
	movl	%eax, -416(%rbp)
# 86:res = t052 arg1 = t051 arg2 = t053 
	movl	-408(%rbp), %eax
	movl	-416(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -412(%rbp)
# 87:res = t054 
	movl	$0, -420(%rbp)
# 88:res = t055 
	movl	$1, -424(%rbp)
# 89:res = t056 arg1 = j arg2 = t055 
	movl	-328(%rbp), %eax
	movl	-424(%rbp), %edx
	subl	%edx, %eax
	movl	%eax, -428(%rbp)
# 90:res = t058 arg1 = t056 
	movl	-428(%rbp), %eax
	movl	$1, %ecx
	imull	%ecx, %eax
	movl	%eax, -436(%rbp)
# 91:res = t057 arg1 = t054 arg2 = t058 
	movl	-420(%rbp), %eax
	movl	-436(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -432(%rbp)
# 92:res = t059 arg1 = reverseBinaryN arg2 = t057 
	leaq	-212(%rbp), %rdx
	movslq	-432(%rbp), %rax
	addq	%rax, %rdx
	movl	(%rdx), %eax
	movl	%eax, -437(%rbp)
# 93:res = binaryN arg1 = t052 arg2 = t059 
	leaq	-108(%rbp), %rdx
	movslq	-412(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-437(%rbp), %eax
	movb	%al, (%rdx)
# 94:res = t060 arg1 = t059 
	movzbl	-437(%rbp), %eax
	movb	%al, -438(%rbp)
# 95:res = t061 arg1 = j 
	movl	-328(%rbp), %eax
	movl	%eax, -442(%rbp)
# 96:res = j arg1 = j 
	movl	-328(%rbp), %eax
	movl	$1, %edx
	subl	%edx, %eax
	movl	%eax, -328(%rbp)
# 97:res = t062 arg1 = i 
	movl	-220(%rbp), %eax
	movl	%eax, -446(%rbp)
# 98:res = i arg1 = i 
	movl	-220(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -220(%rbp)
# 99:
	jmp .L13
# 100:
.L12:
	movq	$.STR2,	%rdi
# 101:res = t063 
	pushq %rbp
	call	printStr
	movl	%eax, -450(%rbp)
	addq $8 , %rsp
# 102:res = t064 
	movl	$0, -454(%rbp)
# 103:res = binaryN 
# 104:res = t065 
	pushq %rbp
	leaq	-108(%rbp), %rdi
	call	printStr
	movl	%eax, -458(%rbp)
	addq $8 , %rsp
# 105:
	movq	$.STR3,	%rdi
# 106:res = t066 
	pushq %rbp
	call	printStr
	movl	%eax, -462(%rbp)
	addq $8 , %rsp
# 107:
	movq	$.STR4,	%rdi
# 108:res = t067 
	pushq %rbp
	call	printStr
	movl	%eax, -466(%rbp)
	addq $8 , %rsp
# 109:res = t068 
	movl	$0, -470(%rbp)
# 110:res = t068 
	movl	-470(%rbp), %eax
	jmp	.LRT0
.LRT0:
	addq	$-470, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE0:
	.size	main, .-main
