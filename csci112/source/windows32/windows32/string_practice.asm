.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA
outstr	BYTE	300 dup (?), 0
str1	BYTE	'City: ', 0			;6 BYTE
str2	BYTE	'State: ', 0		;7 BYTE
string	BYTE	40 dup (?)			;40 BYTE reserved to read 40 character input
prompt1	BYTE	'Enter city', 0
prompt2	BYTE	'Enter state', 0
outlbl	BYTE	'City, State', 0
city	BYTE	40 dup (?), 0
state	BYTE	40 dup (?), 0

.CODE
_MainProc PROC

;20h = space
;0dh and 0ah = newline

	;-----Prompt user to enter a city-----;
		input	prompt1, city, 40


		lea		esi, str1		;esi now points to starting address of str1
		lea		edi, outstr		;destination points to the starting address of outstr
		cld						;copy direction from left to right
		mov		ecx, 6			;6 bytes to be moved
		rep		movsb			;move string byte by byte
		
		lea		esi, city
		lea		edi, outstr+6
		cld
		mov		ecx, 6
		rep		movsb

		mov		outstr+12, 0ah
		output	outlbl, outstr

		lea		esi, str2
		lea		edi, outstr+13
		cld
		mov		ecx, 7
		rep		movsb

		output	outlbl, outstr

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

