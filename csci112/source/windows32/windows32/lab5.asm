;Lab5 CSCI 112
;Bee Cha
;Prompt the user to enter 4 fahrenheit temperature
;Using mul and div operation
;convert fahrenheit to celcius temperature
;then calculate the average temperature

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 8192

.DATA

outlbl	BYTE	'Results', 0
label1	BYTE	'Fahrenheit Temperature:', 0	;23 characters
label2	BYTE	'Celsius Temperature:', 0		;20 characters
label3	BYTE	'Total Average:', 0				;14 characters
prompt1	BYTE    "Enter first temperature", 0
prompt2	BYTE    "Enter second temperature", 0
prompt3	BYTE	"Enter third temperature", 0
prompt4	BYTE	"Enter fourth temperature", 0
string  BYTE    40 DUP (?)
outstr	BYTE	400 DUP (?)
f1		BYTE	11 DUP (?)
f2		BYTE	11 DUP (?)
f3		BYTE	11 DUP (?)
f4		BYTE	11 DUP (?)
five	DWORD	5
nine	DWORD	9
avg		DWORD	11 DUP (?)

.CODE
_MainProc PROC

;20h = space
;0dh = feedline
;0ah = newline
;9h  = horizontal tab

;----------Formula for conversion----------
;             (5 * F -  32) / 9

	;-----Preparing String Output-----;
		lea		esi, label1					;Points to first address of label1
		lea		edi, outstr					;Beginning of our string storage
		cld
		mov		ecx, 23						;to copy 23 characters from label1
		rep		movsb
		mov		outstr+23, 9h				;tab

	;-----First Number-----;
		input	prompt1, string, 40			;Input first temperature reading
		atod	string						;Convert ascii reading to DWORD then it moves it to EAX register
		
		lea		esi, string
		lea		edi, outstr+24
		cld
		mov		ecx, 2
		rep		movsb

		sub		eax, 32						;(F - 32)
		mul		five						;(5 * F - 32)
		div		nine						;(5 * F - 32) / 9
	    ;[edx = remainder][eax = quotient]
		;Ignore remainder fraction part for now
		mov		avg, eax					;to accmulate average
		dtoa	f1, eax						;don't forget to convert to ascii

	;-----Second Number-----;
		input	prompt2, string, 40			;Input second temperature reading
		atod	string						;Convert to DWORD

		mov		outstr+26, 9h
		lea		esi, string
		lea		edi, outstr+27
		cld
		mov		ecx, 2
		rep		movsb

		sub		eax, 32
		mul		five
		div		nine
		add		avg, eax
		dtoa	f2, eax

	;-----Third Number-----;
		input	prompt3, string, 40			;Input third temperature reading
		atod	string						;Convert to DWORD

		mov		outstr+29, 9h
		lea		esi, string
		lea		edi, outstr+30
		cld
		mov		ecx, 2
		rep		movsb

		sub		eax, 32
		mul		five
		div		nine
		add		avg, eax
		dtoa	f3, eax
		;output	outlbl, f3

	;-----Fourth Number-----;
		input	prompt4, string, 40			;Input fourth temperature reading
		atod	string						;Convert to DWORD

		mov		outstr+32, 9h
		lea		esi, string
		lea		edi, outstr+33
		cld
		mov		ecx, 3
		rep		movsb
		mov		outstr+36, 0dh

		sub		eax, 32
		mul		five
		div		nine
		add		avg, eax
		dtoa	f4, eax
		;output	outlbl, f4


	;-----Append Celcius String-----;

		lea		esi, label2					;Points to first address of label2
		lea		edi, outstr+37
		cld
		mov		ecx, 20						;to copy 23 characters from label1
		rep		movsb
		mov		outstr+57, 9h

	;-----Put all four temperature into output string-----;
		
		lea		esi, f1
		lea		edi, outstr+58
		cld
		mov		ecx, 11
		rep		movsb
		mov		outstr+69, 9h

		lea		esi, f2
		lea		edi, outstr+70
		cld
		mov		ecx, 11
		rep		movsb
		mov		outstr+81, 9h

		lea		esi, f3
		lea		edi, outstr+82
		cld
		mov		ecx, 11
		rep		movsb
		mov		outstr+93, 9h

		lea		esi, f4
		lea		edi, outstr+94
		cld
		mov		ecx, 11
		rep		movsb

		mov		outstr+105, 0dh

		;output	outlbl, outstr
		
	;-----Calculate Average-----;
		mov		eax, avg
		cdq
		mov		ebx, 4
		div		ebx
		dtoa	avg, eax

		lea		esi, label3
		lea		edi, outstr+106
		cld
		mov		ecx, 14
		rep		movsb

		mov		outstr+120, 9h

		lea		esi, avg
		lea		edi, outstr+121
		cld
		mov		ecx, 11
		rep		movsb

		output	outlbl, outstr

		;output	outlbl, avg

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

