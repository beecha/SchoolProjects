;Bee Cha
;Lab 10
;Implement a 16-bit ALU
;Perform the 1-bit ALU for each 16-bit
;Do different operation controled by the binv and op
;Output results

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA

prompt1	BYTE	"Enter A: 16-bit binary", 0
prompt2	BYTE	"Enter B: 16-bit binary", 0
prompt3 BYTE	"Enter Control Signal: 3-bit binary", 0
a		BYTE	16 dup(?),0
b		BYTE	16 dup(?),0
binv	BYTE	?
op		BYTE	2 dup(?), 0
arg		BYTE	40 dup(?),0
and_result	DWORD	?
or_result	DWORD	?
xor_result	DWORD	?
add_result	DWORD	?

carry		DWORD	?
result_str	BYTE	2 dup(" "), 0
outlbl	BYTE	"Result 1-Bit ALU", 0
label2	BYTE	"ai", 09h, "bi", 09h, "ci", 09h, "op", 09h, "Si", 09h, "Ci+1", 0dh, 0	;20 characters
outstr	BYTE	400 dup(?), 0


.CODE
_MainProc PROC

		input	prompt1, arg, 40		;Get A input
		mov		ecx, 0
		lea		ebx, arg
		lea		edx, a

	;-----Convert each bit into numeric value then move it to A-----;
loop1:
		mov		AL, BYTE ptr [ebx]
		sub		AL, 30h
		mov		BYTE PTR [edx], AL
		
		inc		edx
		inc		ebx
		inc		ecx

		cmp		ecx, 16
		jl		loop1

		input	prompt2, arg, 40		;Get B input
		mov		ecx, 0
		lea		ebx, arg
		lea		edx, b

	;-----Convert each bit into numeric value then move it to B-----;
loop2:
		mov		AL, BYTE ptr [ebx]
		sub		AL, 30h
		mov		BYTE PTR [edx], AL
		
		inc		edx
		inc		ebx
		inc		ecx

		cmp		ecx, 16
		jl		loop2

		
		input	prompt3, arg, 40		;Get control signal input
		lea		ecx, arg
		mov		AL, BYTE PTR [ecx]
		sub		AL, 30h					;Convert Binv to numeric value

		mov		binv, AL

		inc		ecx
		mov		AL, BYTE PTR [ecx]
		sub		AL, 30h					;First OP bit

		inc		ecx
		mov		BL, BYTE PTR [ecx]
		sub		BL, 30h					;Zeroth OP bit
		
		mov		DL, 0
		cmp		AL, 1
		jne		skip1
		add		DL, 2
skip1:
		cmp		BL, 1
		jne		skip2
		add		DL, 1
skip2:
		lea		ebx, op
		mov		BYTE PTR [ebx], DL		;Stores corresponding OP code, 0 1 2

	;-----Now you have the corresponding arguments: A, B, binv, and op-----;
	;-----Perform 1-bit ALU operation on each bit-----;


		lea		ecx, a
		lea		edx, b
		mov		eax, [ecx+15]
		and		eax, [edx+15]

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP

test_proc	PROC

		push	ebp
		mov		ebp, esp

		mov		eax, [ebp+8]
		and		eax, [ebp+12]

		pop		ebp
		ret

test_proc	ENDP

one_bit		PROC

		;---STACK---;
		;	[ebp+8]		= address of binv
		;	[ebp+12]	= address of op
		;	[ebp+16]	= address of b
		;	[ebp+20]	= address of a
		
		;Compare OP code to determine what operation to do
		;If OP = 1, then do subraction

		mov		eax, 4


SUBTRACTION:

		push	ebp
		mov		ebp, esp

		pop		ebp
		ret

one_bit		ENDP

	;-----GATE PROCEDURES-----;

AND_gate	PROC

	;-----AND_gate takes parameters a and b then it will AND the results back-----;
		push	ebp
		mov		ebp, esp
		
		mov		eax, [ebp+12]
		and		eax, [ebp+8]

		pop		ebp
		ret

AND_gate	ENDP

OR_gate		PROC

	;-----OR_gate takes parameters a and b then it will OR the results back-----;
		push	ebp
		mov		ebp, esp

		mov		eax, [ebp+12]
		or		eax, [ebp+8]

		pop		ebp
		ret

OR_gate		ENDP

XOR_gate	PROC

		push	ebp
		mov		ebp, esp
		mov		eax, [ebp+12]
		xor		eax, [ebp+8]

		pop		ebp
		ret

XOR_gate	ENDP

full_adder	PROC

	;-----Full Adder: Ai XOR Bi XOR cin-----;
		;[ebp+8]	= binv
		;[ebp+12]	= and_result
		;[ebp+16]	= xor_result

		push	ebp
		mov		ebp, esp

		;xor_result AND binv
		;If subraction, AND gate will invert B
		mov		eax, [ebp+16]		;xor_result
		and		eax, [ebp+8]		;xor_result AND binv

		;(xor_result AND binv) OR and_result
		or		eax, [ebp+12]		;carry result

		pop		ebp
		ret

full_adder	ENDP

END                             ; end of source code

