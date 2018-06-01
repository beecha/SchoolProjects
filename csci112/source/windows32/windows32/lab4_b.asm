;Lab 4
;Bee Cha
;Declare 2 array of type DWORD with 5 elements
;Perform simple arithmetic on each element in the array
;Then swap and exchange the 2 array elements with each other
;eax : DWORD SIZE
;ax  : WORD SIZE
;ah/al : BYTE SIZE
;Without using ECX register or loops

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
		output	aone, [ebx]			;output each memory DWORD size address
		output	aone, [ebx+4]
		output	aone, [ebx+8]
		output	aone, [ebx+12]
		output	aone, [ebx+16]

;-------------------------------------------------------



;----------Output the intial values of array2----------

		lea		ebx, array2				;get the address of array2
		output	atwo, [ebx]
		output	atwo, [ebx+4]
		output	atwo, [ebx+8]
		output	atwo, [ebx+12]
		output	atwo, [ebx+16]

;----------Add 2 to each element in array1----------

		lea		ebx, array1				;get the address of array1
		mov		eax, [ebx]				;copy ebx to eax first to add
		add		eax, 2					;add 2 to each element
		mov		[ebx], eax				;then move it back to memory address
		mov		eax, [ebx+4]			;repeat for each element
		add		eax, 2
		mov		[ebx+4], eax
		mov		eax, [ebx+8]
		add		eax, 2
		mov		[ebx+12], eax
		mov		eax, [ebx+16]
		add		eax, 2
		mov		[ebx+16], eax

		output	aone_, [ebx]			;output what ebx points to
		output	aone_, [ebx+4]
		output	aone_, [ebx+8]
		output	aone_, [ebx+12]
		output	aone_, [ebx+16]

;----------------------------------------------------



;----------Minus 2 to each element in array2---------

		lea		ebx, array2				;get the address of array2

		mov		eax, [ebx]				;move contents of ebx to eax
		sub		eax, 2					;subtract 2 to eax then move it back to ebx
		mov		[ebx], eax
		mov		eax, [ebx+4]			;repeat for each element
		sub		eax, 2
		mov		[ebx+4], eax
		mov		eax, [ebx+8]
		sub		eax, 2
		mov		[ebx+8], eax
		mov		eax, [ebx+12]
		sub		eax, 2
		mov		[ebx+12], eax
		mov		eax, [ebx+16]
		sub		eax, 2
		mov		[ebx+16], eax

		output	atwo_, [ebx]			;output what ebx points to
		output	atwo_, [ebx+4]
		output	atwo_, [ebx+8]
		output	atwo_, [ebx+12]
		output	atwo_, [ebx+16]

;-----------------------------------------------------



;---------Exchange/Swap array1 with array2----------

		lea		ebx, array1				;get the address of array1
		lea		edx, array2				;get the address of array2
		
		;xchg	[ebx], [edx+16]			;move contents of edx to ebx
		mov		eax, [ebx+16]
		xchg	eax, [edx]
		xchg	[ebx+16], eax

		mov		eax, [ebx+12]
		xchg	eax, [edx+4]
		xchg	[ebx+12], eax

		mov		eax, [ebx+8]
		xchg	eax, [edx+8]
		xchg	[ebx+8], eax

		mov		eax, [ebx+4]
		xchg	eax, [edx+12]
		xchg	[ebx+4], eax

		mov		eax, [ebx]
		xchg	eax, [edx+16]
		xchg	[ebx], eax

;----------------------------------------------------



;----------Output the arrays with swapped conents----------

		lea		ebx, array1				;get the address of array1
		lea		edx, array2				;get the address of array2

		output	aswap1, [ebx]			;output what ebx points to
		output	aswap1, [ebx+4]
		output	aswap1, [ebx+8]
		output	aswap1, [ebx+12]
		output	aswap1, [ebx+16]

		output	aswap2, [edx]			;output what edx points to
		output	aswap2, [edx+4]
		output	aswap2,	[edx+8]
		output	aswap2, [edx+12]
		output	aswap2, [edx+16]

;-----------------------------------------------------------
quit:
        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

