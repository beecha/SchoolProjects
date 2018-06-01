;Lab 4
;Bee Cha
;Declare 2 array of type DWORD with 5 elements
;Perform simple arithmetic on each element in the array
;Then swap and exchange the 2 array elements with each other
;eax : DWORD SIZE
;ax  : WORD SIZE
;ah/al : BYTE SIZE
;Using ECX as the accumulator

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA

array1	DWORD	5 DUP (21H, 22H, 23H, 24H, 25H)
array2	DWORD	5 DUP (31H, 32H, 33H, 34H, 35H)
nbrElts	DWORD	5
aone	BYTE	"Array1 Contents", 0
atwo	BYTE	"Array2 Contents", 0
aone_	BYTE	"Array1 Contents + 2", 0
atwo_	BYTE	"Array2 Contents - 2", 0
aswap1	BYTE	"Array1 Swapped Contents", 0
aswap2	BYTE	"Array2 Swapped Contents", 0

.CODE
_MainProc PROC


;----------Output the intial values of array1----------

		lea		ebx, array1				;get the address of array1
		mov		ecx, nbrElts			;cout := nbrElts
		;jecxz	quit					;quit if there are no elements
forCount1:
		output	aone, [ebx]		;output what ebx points to
		add		ebx, 4					;add 4 for the next DWORD memory address
		loop	forCount1				;repeat for nbrElts times

;-------------------------------------------------------



;----------Output the intial values of array2----------

		lea		ebx, array2				;get the address of array2
		mov		ecx, nbrElts			;cout := nbrElts
;		jecxz	quit					;quit if there are no elements
forCount2:
		output	atwo, [ebx]				;output what ebx points to
		add		ebx, 4					;add 4 for the next DWORD memory address
		loop	forCount2				;repeat for nbrElts times


;----------Add 2 to each element in array1----------

		lea		ebx, array1				;get the address of array1
		mov		ecx, nbrElts			;cout := nbrElts
;		jecxz	quit					;quit if there are no elements
forCount3:
		mov		eax, [ebx]				;move contents of ebx to eax
		add		eax, 2					;add 2 to eax then move it back to ebx
		mov		[ebx], eax
		output	aone_, [ebx]			;output what ebx points to
		add		ebx, 4					;add 4 for the next DWORD memory address
		loop	forCount3				;repeat for nbrElts times

;----------------------------------------------------



;----------Minus 2 to each element in array2---------

		lea		ebx, array2				;get the address of array2
		mov		ecx, nbrElts			;cout := nbrElts
;		jecxz	quit					;quit if there are no elements
forCount4:
		mov		eax, [ebx]				;move contents of ebx to eax
		sub		eax, 2					;subtract 2 to eax then move it back to ebx
		mov		[ebx], eax
		output	atwo_, [ebx]			;output what ebx points to
		add		ebx, 4					;add 4 for the next DWORD memory address
		loop	forCount4				;repeat for nbrElts times

;-----------------------------------------------------



;---------Exchange/Swap array1 with array2----------

		lea		ebx, array1				;get the address of array1
		lea		edx, array2				;get the address of array2
		mov		ecx, nbrElts			;cout := nbrElts
		;jecxz	quit					;quit if there are no elements
forCount5:
		xchg	ebx, edx				;move contents of edx to ebx
		add		ebx, 4					;add 4 for the next DWORD memory address
		add		edx, 4
		loop	forCount5				;repeat for nbrElts times

;----------------------------------------------------



;----------Output the arrays with swapped conents----------

		lea		ebx, array1				;get the address of array1
		lea		edx, array2				;get the address of array2
		mov		ecx, nbrElts
forCount6:
		output	aswap1, [ebx]			;output what ebx points to
		add		ebx, 4
		loop	forCount6

		mov		ecx, nbrElts
forCount7:
		output	aswap2, [edx]
		add		edx, 4
		loop	forCount7

;-----------------------------------------------------------
quit:
        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

