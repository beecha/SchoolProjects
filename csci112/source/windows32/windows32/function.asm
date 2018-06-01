.586
.model Flat

INCLUDE myMacro.h

.code

fibo PROC

;-----Definition of Fibonacci number-----;
; Fibo(N) = Fibo(N-1) + Fibo(N-2)
; Fibo(1) = Fibo(2) = 1 //Termination Case

	;-----Establish the stack-----;
		push	ebp				;base pointer, or the tail of the stack
		mov		ebp, esp		;establish where the stack pointer starts from

	;-----Load the registers, or load the arguments/parameters-----;
		push	ebx
		mov		ebx, [ebp+8]


	;-----Termination, check if N = 1 or N = 2-----;
		cmp		ebx, 2
		jle		Done
		dec		ebx
		push	ebx
		call	fibo
		add		esp, 4

Done:
		add		eax, 1
	;-----Clear the stack-----;
		pop		ebx
		pop		ebp
		ret

fibo ENDP

COMMENT @
fctn1	PROC
		push	ebp
		mov		ebp, esp
		push	ebx

		mov		eax, [ebp+8]	;x
		imul	eax, 3			;3*x
		mov		ebx, [ebp+12]	;y
		imul	ebx, 7			;7*y
		add		eax, ebx		;(3*x)+(7*y)

		pop		ebx
		pop		ebp
		ret
fctn1	ENDP
@

test1	PROC
		push	ebp
		mov		ebp, esp
		push	edx
		mov		edx, eax

		;-----Do Something-----;
		cmp		eax, 5
		jge		Finish
		inc		eax
		call	test1

Finish:
		pop		edx
		pop		ebp
		ret
test1	ENDP

END