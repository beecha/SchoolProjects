;Example assembly language

.586
.MODEL FLAT

.STACK 4096

.DATA
number	DWORD	-105
sum		DWORD	?
.CODE

main PROC
	MOV		eax, number
	ADD		eax, 158
	MOV		sum, eax
	MOV		eax, 0
	RET
main ENDP
END