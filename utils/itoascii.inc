;description:convert an integer into an ascii string
;usage:
;input:esi should contain the integer
;output:eax will point to the converted ascii string
;author:FancyBread
section .bss
	curr_div resb 128
	itoascii_result resb 128

section .text
	global itoascii

itoascii:
	xor eax, eax

	mov edi, itoascii_result
	mov ecx, 32
	rep stosd

	mov edi, curr_div
	mov ecx, 32
	rep stosd

	mov byte [curr_div], 1
	mov edi, itoascii_result

.max_loop:
	mov eax, [curr_div]
        mov ebx, 10
        xor edx, edx
        mul ebx
        mov [curr_div], eax

	mov eax, esi
	mov ebx, [curr_div]
	xor edx, edx
	div ebx

	cmp eax, 10
	jge .max_loop

.isolate_loop:
	mov eax, esi
	mov ebx, [curr_div]
	xor edx, edx
	div ebx

	add eax, '0'
	stosb

	mov esi, edx

	mov eax, [curr_div]
	mov ebx, 10
	xor edx, edx
	div ebx
	mov [curr_div], eax

	cmp byte [curr_div], 0
	jne .isolate_loop

.finish:
	lea eax, [itoascii_result]

	ret
