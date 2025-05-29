section .data
	prompt0 db 'Enter the first number:'
	prompt0Len equ $-prompt0

	prompt1 db 'Enter the second number:'
	prompt1Len equ $-prompt1

	prompt2 db 'Enter the wanted action(add, sub, mul, div):'
	prompt2Len equ $-prompt2

	res db 'Result:'
	resLen equ $-res

	str0 db 'add', 0
	str1 db 'sub', 0
	str2 db 'mul', 0
	str3 db 'div', 0

section .bss
	num resb 128
	action resb 32

section .text
	global _start

%include "utils/asciitoi.inc"
%include "utils/itoascii.inc"

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt0
	mov edx, prompt0Len

	int 0x80

	mov eax, 3
	mov ebx, 0
	mov ecx, num
	mov edx, 128

	int 0x80

	mov byte [num + eax - 1], 0

	mov esi, num
	call asciitoi

	push eax

	mov edi, num
	mov ecx, 32
	xor eax, eax
	rep stosd

	mov eax, 4
        mov ebx, 1
        mov ecx, prompt1
        mov edx, prompt1Len

        int 0x80

	mov eax, 3
        mov ebx, 0
        mov ecx, num
        mov edx, 128

        int 0x80

        mov byte [num + eax - 1], 0

        mov esi, num
        call asciitoi

	mov ebx, eax

	push ebx

	mov eax, 4
	mov ebx, 1
	mov ecx, prompt2
	mov edx, prompt2Len

	int 0x80

	mov eax, 3
        mov ebx, 0
        mov ecx, action
        mov edx, 128

        int 0x80

        mov byte [action + eax - 1], 0

	pop ebx
	pop eax

	mov edx, [action]

	cmp edx, [str0]
	je addition

	cmp edx, [str1]
	je subtract

	cmp edx, [str2]
	je multiply

	cmp edx, [str3]
	je divide

addition:
	add eax, ebx
	jmp output

subtract:
	sub eax, ebx
	jmp output

multiply:
	xor edx, edx
	mul ebx
	jmp output

divide:
	xor edx, edx
	div ebx
	jmp output

output:
	mov esi, eax

	call itoascii

	push eax

	mov eax, 4
        mov ebx, 1
        mov ecx, res
        mov edx, resLen

        int 0x80

	pop eax

	mov ecx, eax
	mov edx, 128
	mov eax, 4
	mov ebx, 1

	int 0x80

exit:
	mov eax, 1
	xor ebx, ebx

	int 0x80
