	.file	"output.s"

.STR0:	.string "_________ Rod Cutting Problem _________\n"
.STR1:	.string "Input the size of array(n):\n"
.STR2:	.string "Input the (n) elements of the array\n"
.STR3:	.string "The maximum value obtainable for rod cutting problem is:"
.STR4:	.string "\n"
.STR5:	.string "\n_______________________________________________\n"
	.text
	.globl	max
	.type	max, @function
max:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$8, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
# 0:arg1 = a arg2 = b 
	movl	-8(%rbp), %eax
	movl	-4(%rbp), %edx
	cmpl	%edx, %eax
	jg .L1
# 1:
	jmp .L2
# 2:
	jmp	.LRT0
# 3:res = a 
.L1:
	movl	-8(%rbp), %eax
	jmp	.LRT0
# 4:
	jmp	.LRT0
# 5:res = b 
.L2:
	movl	-4(%rbp), %eax
	jmp	.LRT0
# 6:
	jmp	.LRT0
.LRT0:
	addq	$-8, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE0:
	.size	max, .-max
	.globl	func
	.type	func, @function
func:
.LFB1:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$572, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -12(%rbp)
# 7:res = t000 
.L3:
	movl	$100, -416(%rbp)
# 8:res = t001 
	movl	$0, -420(%rbp)
# 9:res = t002 
	movl	$0, -424(%rbp)
# 10:res = t004 arg1 = t002 
	movl	-424(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -432(%rbp)
# 11:res = t003 arg1 = t001 arg2 = t004 
	movl	-420(%rbp), %eax
	movl	-432(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -428(%rbp)
# 12:res = t005 
	movl	$0, -436(%rbp)
# 13:res = val arg1 = t003 arg2 = t005 
	leaq	-412(%rbp), %rdx
	movslq	-428(%rbp), %rax
	addq	%rax, %rdx
	movl	-436(%rbp), %eax
	movl	%eax, (%rdx)
# 14:res = t006 arg1 = t005 
	movl	-436(%rbp), %eax
	movl	%eax, -440(%rbp)
# 15:res = t007 
	movl	$0, -456(%rbp)
# 16:res = max_val arg1 = t007 
	movl	-456(%rbp), %eax
	movl	%eax, -452(%rbp)
# 17:res = t008 
	movl	$1, -460(%rbp)
# 18:res = i arg1 = t008 
	movl	-460(%rbp), %eax
	movl	%eax, -444(%rbp)
# 19:res = t009 arg1 = t008 
	movl	-460(%rbp), %eax
	movl	%eax, -464(%rbp)
# 20:arg1 = i arg2 = n 
.L6:
	movl	-444(%rbp), %eax
	movl	-4(%rbp), %edx
	cmpl	%edx, %eax
	jle .L4
# 21:
	jmp .L5
# 22:
	jmp .L5
# 23:res = t010 arg1 = i 
.L11:
	movl	-444(%rbp), %eax
	movl	%eax, -468(%rbp)
# 24:res = i arg1 = i 
	movl	-444(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -444(%rbp)
# 25:
	jmp .L6
# 26:res = t011 
.L4:
	movl	$0, -472(%rbp)
# 27:res = max_val arg1 = t011 
	movl	-472(%rbp), %eax
	movl	%eax, -452(%rbp)
# 28:res = t012 
	movl	$0, -476(%rbp)
# 29:res = j arg1 = t012 
	movl	-476(%rbp), %eax
	movl	%eax, -448(%rbp)
# 30:res = t013 arg1 = t012 
	movl	-476(%rbp), %eax
	movl	%eax, -480(%rbp)
# 31:arg1 = j arg2 = i 
.L9:
	movl	-448(%rbp), %eax
	movl	-444(%rbp), %edx
	cmpl	%edx, %eax
	jl .L7
# 32:
	jmp .L8
# 33:
	jmp .L8
# 34:res = t014 arg1 = j 
.L10:
	movl	-448(%rbp), %eax
	movl	%eax, -484(%rbp)
# 35:res = j arg1 = j 
	movl	-448(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -448(%rbp)
# 36:
	jmp .L9
# 37:res = t015 
.L7:
	movl	$0, -488(%rbp)
# 38:res = t017 arg1 = j 
	movl	-448(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -496(%rbp)
# 39:res = t016 arg1 = t015 arg2 = t017 
	movl	-488(%rbp), %eax
	movl	-496(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -492(%rbp)
# 40:res = t018 arg1 = price arg2 = t016 
	movq	-12(%rbp), %rdx
	movslq	-492(%rbp), %rax
	addq	%rax, %rdx
	movl	(%rdx), %eax
	movl	%eax, -500(%rbp)
# 41:res = t019 
	movl	$0, -504(%rbp)
# 42:res = t020 arg1 = i arg2 = j 
	movl	-444(%rbp), %eax
	movl	-448(%rbp), %edx
	subl	%edx, %eax
	movl	%eax, -508(%rbp)
# 43:res = t021 
	movl	$1, -512(%rbp)
# 44:res = t022 arg1 = t020 arg2 = t021 
	movl	-508(%rbp), %eax
	movl	-512(%rbp), %edx
	subl	%edx, %eax
	movl	%eax, -516(%rbp)
# 45:res = t024 arg1 = t022 
	movl	-516(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -524(%rbp)
# 46:res = t023 arg1 = t019 arg2 = t024 
	movl	-504(%rbp), %eax
	movl	-524(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -520(%rbp)
# 47:res = t025 arg1 = val arg2 = t023 
	leaq	-412(%rbp), %rdx
	movslq	-520(%rbp), %rax
	addq	%rax, %rdx
	movl	(%rdx), %eax
	movl	%eax, -528(%rbp)
# 48:res = t026 arg1 = t018 arg2 = t025 
	movl	-500(%rbp), %eax
	movl	-528(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -532(%rbp)
# 49:res = max_val 
# 50:res = t026 
# 51:res = t027 
	pushq %rbp
	movl	-532(%rbp) , %edi
	movl	-452(%rbp) , %esi
	call	max
	movl	%eax, -536(%rbp)
	addq $0 , %rsp
# 52:res = max_val arg1 = t027 
	movl	-536(%rbp), %eax
	movl	%eax, -452(%rbp)
# 53:res = t028 arg1 = t027 
	movl	-536(%rbp), %eax
	movl	%eax, -540(%rbp)
# 54:
	jmp .L10
# 55:res = t029 
.L8:
	movl	$0, -544(%rbp)
# 56:res = t031 arg1 = i 
	movl	-444(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -552(%rbp)
# 57:res = t030 arg1 = t029 arg2 = t031 
	movl	-544(%rbp), %eax
	movl	-552(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -548(%rbp)
# 58:res = val arg1 = t030 arg2 = max_val 
	leaq	-412(%rbp), %rdx
	movslq	-548(%rbp), %rax
	addq	%rax, %rdx
	movl	-452(%rbp), %eax
	movl	%eax, (%rdx)
# 59:res = t032 arg1 = max_val 
	movl	-452(%rbp), %eax
	movl	%eax, -556(%rbp)
# 60:
	jmp .L11
# 61:res = t033 
.L5:
	movl	$0, -560(%rbp)
# 62:res = t035 arg1 = n 
	movl	-4(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -568(%rbp)
# 63:res = t034 arg1 = t033 arg2 = t035 
	movl	-560(%rbp), %eax
	movl	-568(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -564(%rbp)
# 64:res = t036 arg1 = val arg2 = t034 
	leaq	-412(%rbp), %rdx
	movslq	-564(%rbp), %rax
	addq	%rax, %rdx
	movl	(%rdx), %eax
	movl	%eax, -572(%rbp)
# 65:res = t036 
	movl	-572(%rbp), %eax
	jmp	.LRT1
.LRT1:
	addq	$-572, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE1:
	.size	func, .-func
	.globl	main
	.type	main, @function
main:
.LFB2:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$524, %rsp
# 66:res = t037 
	movl	$100, -404(%rbp)
# 67:
	movq	$.STR0,	%rdi
# 68:res = t038 
	pushq %rbp
	call	printStr
	movl	%eax, -420(%rbp)
	addq $8 , %rsp
# 69:
	movq	$.STR1,	%rdi
# 70:res = t039 
	pushq %rbp
	call	printStr
	movl	%eax, -424(%rbp)
	addq $8 , %rsp
# 71:res = t040 
	movl	$1, -432(%rbp)
# 72:res = err arg1 = t040 
	movl	-432(%rbp), %eax
	movl	%eax, -428(%rbp)
# 73:res = t041 arg1 = err 
	leaq	-428(%rbp), %rax
	movq	%rax, -440(%rbp)
# 74:res = t041 
# 75:res = t042 
	pushq %rbp
	movq	-440(%rbp), %rdi
	call	readInt
	movl	%eax, -444(%rbp)
	addq $0 , %rsp
# 76:res = n arg1 = t042 
	movl	-444(%rbp), %eax
	movl	%eax, -412(%rbp)
# 77:res = t043 arg1 = t042 
	movl	-444(%rbp), %eax
	movl	%eax, -448(%rbp)
# 78:
	movq	$.STR2,	%rdi
# 79:res = t044 
	pushq %rbp
	call	printStr
	movl	%eax, -452(%rbp)
	addq $8 , %rsp
# 80:res = t045 
	movl	$0, -456(%rbp)
# 81:res = i arg1 = t045 
	movl	-456(%rbp), %eax
	movl	%eax, -408(%rbp)
# 82:res = t046 arg1 = t045 
	movl	-456(%rbp), %eax
	movl	%eax, -460(%rbp)
# 83:arg1 = i arg2 = n 
.L14:
	movl	-408(%rbp), %eax
	movl	-412(%rbp), %edx
	cmpl	%edx, %eax
	jl .L12
# 84:
	jmp .L13
# 85:
	jmp .L13
# 86:res = t047 arg1 = i 
.L15:
	movl	-408(%rbp), %eax
	movl	%eax, -464(%rbp)
# 87:res = i arg1 = i 
	movl	-408(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -408(%rbp)
# 88:
	jmp .L14
# 89:res = t048 
.L12:
	movl	$0, -468(%rbp)
# 90:res = t050 arg1 = i 
	movl	-408(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -476(%rbp)
# 91:res = t049 arg1 = t048 arg2 = t050 
	movl	-468(%rbp), %eax
	movl	-476(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -472(%rbp)
# 92:res = t051 arg1 = err 
	leaq	-428(%rbp), %rax
	movq	%rax, -484(%rbp)
# 93:res = t051 
# 94:res = t052 
	pushq %rbp
	movq	-484(%rbp), %rdi
	call	readInt
	movl	%eax, -488(%rbp)
	addq $0 , %rsp
# 95:res = arr arg1 = t049 arg2 = t052 
	leaq	-400(%rbp), %rdx
	movslq	-472(%rbp), %rax
	addq	%rax, %rdx
	movl	-488(%rbp), %eax
	movl	%eax, (%rdx)
# 96:res = t053 arg1 = t052 
	movl	-488(%rbp), %eax
	movl	%eax, -492(%rbp)
# 97:
	jmp .L15
# 98:res = t054 
.L13:
	movl	$0, -496(%rbp)
# 99:res = arr 
# 100:res = n 
# 101:res = t055 
	pushq %rbp
	movl	-412(%rbp) , %edi
	leaq	-400(%rbp), %rsi
	call	func
	movl	%eax, -500(%rbp)
	addq $0 , %rsp
# 102:res = ans arg1 = t055 
	movl	-500(%rbp), %eax
	movl	%eax, -416(%rbp)
# 103:res = t056 arg1 = t055 
	movl	-500(%rbp), %eax
	movl	%eax, -504(%rbp)
# 104:
	movq	$.STR3,	%rdi
# 105:res = t057 
	pushq %rbp
	call	printStr
	movl	%eax, -508(%rbp)
	addq $8 , %rsp
# 106:res = ans 
# 107:res = t058 
	pushq %rbp
	movl	-416(%rbp) , %edi
	call	printInt
	movl	%eax, -512(%rbp)
	addq $0 , %rsp
# 108:
	movq	$.STR4,	%rdi
# 109:res = t059 
	pushq %rbp
	call	printStr
	movl	%eax, -516(%rbp)
	addq $8 , %rsp
# 110:
	movq	$.STR5,	%rdi
# 111:res = t060 
	pushq %rbp
	call	printStr
	movl	%eax, -520(%rbp)
	addq $8 , %rsp
# 112:res = t061 
	movl	$0, -524(%rbp)
# 113:res = t061 
	movl	-524(%rbp), %eax
	jmp	.LRT2
.LRT2:
	addq	$-524, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE2:
	.size	main, .-main
