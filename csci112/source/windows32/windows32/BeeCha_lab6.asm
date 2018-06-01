;Lab6 CSCI 112
;Bee Cha
;Prompt the user to enter their name
;Prompt the user to enter N number of test scores (N = 1~10)
;If N is out of range, then throw an error to reenter N
;Test scores range (0~100)
;Purpose of the lab, N=8
;Scores: 76, 88, 95, 67, 59, 84, 95, 77
;Using loop instructions, store each test score into an array
;Using loop instructions, calculate total store and average
;Then output the results in one box


.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 8192

.DATA

outlbl	BYTE	'Student Record', 0
label1	BYTE	'Results for ', 0				;12 characters
label2	BYTE	'Total Score: ', 0				;13 characters
label3	BYTE	'Total Average: ', 0			;15 characters
prompt1	BYTE    "Enter your name", 0
prompt2	BYTE    "Enter number of test score", 0
prompt3	BYTE	"Enter Scores", 0
errlbl	BYTE	'ERROR', 0
error1	BYTE	'Incorrrect range. Please enter 1~10', 0
string  BYTE    40 DUP (?)
outstr	BYTE	400 DUP (?)
t_score	DWORD	10 DUP (0)
numele	DWORD	?
sum		DWORD	?
sumstr	BYTE	11 DUP (?)
avg		DWORD	?
avgstr	BYTE	11 DUP (?)

.CODE
_MainProc PROC


	;-----Prepare string for output-----;

		lea		esi, label1					;12 characters
		lea		edi, outstr
		cld
		mov		ecx, 12
		rep		movsb

	;-----Get User's name-----;

		input	prompt1, string, 40			;Tell user to enter name
		;output	outlbl, string

	;-----Append name to output string-----;

		lea		esi, string
		lea		edi, outstr+12
		cld
		mov		ecx, 3
		rep		movsb
		mov		outstr+15, 0dh
		;output	outlbl, outstr

		jmp		INPUT_N						;initial skip of the error label

	;-----Prompt user to enter N-----;

REENTER:
		output	errlbl, error1

INPUT_N:
		input	prompt2, string, 4
		atod	string						;convert ASCII to DWORD
		mov		numele, eax

	;-----Compare if N is less than 1-----;
	;-----EAX should contain the DWORD value of N-----;

		cmp		eax, 1
		jl		REENTER
	
	;-----Compare if N is greater than 10-----;
		cmp		eax, 10
		jg		REENTER

	;-----Using loop to prompt user to enter N number of scores into array-----;
	;While i < N
	;	store number into array[i]
	;	i++
	;End While
	;
	;In assembly's case, it'll be array[j] where j is incremented by 4
	;array[j]
	;j+=4

		lea		ebx, t_score			;starting address of array
		mov		ecx, eax				;Move N to ecx

IN_ARRAY:
		input	prompt3, string, 10
		atod	string
		mov		DWORD PTR [ebx], eax
		add		ebx, 4
		loop	IN_ARRAY

	;-----Calculate total average using loop instruction-----;
	;-----Total Score and Average-----;
	;76+88+95+67+59+84+95+77 = 641 or 281h
	;641/8 = 80.125 or 50h

		lea		ebx, t_score
		mov		ecx, numele
		mov		eax, 0					;start sum = 0

AVG_LOOP:
		add		eax, [ebx]
		add		ebx, 4
		loop	AVG_LOOP
		mov		sum, eax

		div		numele					;total divide by number of elements
		mov		avg, eax

	;-----Append results into string-----;

		lea		esi, label2
		lea		edi, outstr+16		;13 characters
		cld
		mov		ecx, 13
		rep		movsb


		mov		eax, sum
		dtoa	sumstr, eax
		lea		esi, sumstr
		lea		edi, outstr+29
		cld
		mov		ecx, 11
		rep		movsb
		mov		outstr+40, 0dh

		lea		esi, label3
		lea		edi, outstr+41		;15 characters
		cld
		mov		ecx, 15
		rep		movsb

		mov		eax, avg
		dtoa	avgstr, eax
		lea		esi, avgstr
		lea		edi, outstr+56
		cld
		mov		ecx, 11
		rep		movsb

		output	outlbl, outstr

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

