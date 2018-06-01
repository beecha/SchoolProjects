
.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output
INCLUDE	myMacro.h


.STACK 4096

.DATA

prompt1	BYTE	"Enter a number", 0
num_N	BYTE	11 DUP (?)
;count	DWORD	?
;number1 DWORD	3
;number2 DWORD	7
;dummy	DWORD	255

EXTERN fibo:PROC
;EXTERN fctn1:PROC
EXTERN test1:PROC

.CODE
_MainProc PROC

	;-----Macro Test-----;
		add2	100, 1

	;-----Get user to input number-----;
		input	prompt1, num_N, 11
		atod	num_N

		push	eax			;push N into the stack

		mov		eax, 0
		;push	dummy

		call fibo

		;push number1
		;push number2
		;call fctn1

		call test1

		add		esp, 4

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

