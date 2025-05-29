;description:convert an ascii string into an integer
;usage:
;input:esi should contain the null terminated string
;output:eax will contain the converted integer
;author:FancyBread
section .bss
	curr_ascii resb 1
	asciitoi_result resb 128

section .text
	global asciitoi

asciitoi:
	mov edi, asciitoi_result
	mov ecx, 32
	xor eax, eax
	rep stosd

	cld
	mov byte [curr_ascii], 0
	mov byte [asciitoi_result], 0

.loop:
	mov edi, curr_ascii
	movsb
	cmp byte [curr_ascii], 0
	je .finish

	mov eax, [asciitoi_result]
	mov ebx, 10
	xor edx, edx
	mul ebx
	mov [asciitoi_result], eax

	sub byte [curr_ascii], '0'

	mov al, [curr_ascii]
	add [asciitoi_result], al

	jmp .loop

.finish:
	mov eax, [asciitoi_result]

	ret
