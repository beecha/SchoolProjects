.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 8192

.DATA

outlbl	BYTE	'Testing String', 0
label1	BYTE	'Name:' , 0						;6 characters
label2	BYTE	'Total Score: ', 0				;13 characters
label3	BYTE	'Total Average: ', 0			;15 characters
prompt1	BYTE    "Enter your name", 0
prompt2	BYTE    "Enter number of test score", 0
prompt3	BYTE	"Enter Scores", 0
errlbl	BYTE	'ERROR', 0
error1	BYTE	'Incorrrect range. Please enter 1~10', 0
string  BYTE    40 DUP (20h)
outstr	BYTE	400 DUP (?)
t_score	DWORD	10 DUP (0)
numele	DWORD	?
sum		DWORD	?
sumstr	BYTE	11 DUP (?)
avg		DWORD	?
avgstr	BYTE	11 DUP (?)

.CODE
_MainProc PROC
		
		input	prompt1, string, 40				;prompt user to enter name

		lea		esi, string
		lea		edi, outstr
		cld
		mov		ecx, 40
		rep		movsb
		mov		outstr+40, 0dh

		lea		esi, label2
		lea		edi, outstr+41
		cld
		mov		ecx, 13
		rep		movsb

		output	outlbl, outstr


        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

