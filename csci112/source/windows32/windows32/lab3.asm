;Cha, Bee
;CSCI 112, Lab 3
;This program calculates the user's age
;It will prompt the user to enter their birth month, birth day, and birth year
;It will use jump instructions (conditions) to calculate the user's age, similar to if and else higher level languages
;Then it will output in a window the user's age

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA
u_month	DWORD   ?
u_day	DWORD   ?
u_year	DWORD	?
result	WORD	?	
prompt1	BYTE    "Enter month", 0
prompt2	BYTE    "Enter day", 0
prompt3	BYTE	"Enter year", 0
string  BYTE    40 DUP (?)
;resultLbl  BYTE  "OOOOOO", 0
greet   BYTE    "Hello", 0
age_result BYTE	"Your age"
sum     BYTE    11 DUP (?), 0
take1   BYTE	"Enter first number to compare", 0
take2   BYTE	"Enter second number to compare", 0
;num1    DWORD	10

.CODE
_MainProc PROC

		;JMP		TEST_OPERATIONS

;---------------------Prompt user for Month, Day, and Year-----------------------------
        input   prompt1, string, 40      ; read ASCII characters
        atod    string          ; convert to integer
        mov     u_month, eax    ; store in memory

        input   prompt2, string, 40      ; repeat for second number
        atod    string
        mov     u_day, eax

        input   prompt3, string, 40      ; repeat for second number
        atod    string
        mov     u_year, eax
;---------------------------------------------------------------------------------------


	;memory address 'u_month' is stored
	;memory address 'u_day' is stored
	;memory address 'u_year' is stored


	;Just testing some jump operations
;TEST_OPERATIONS:
;		MOV		eax, num1
;		CMP		eax, 11
;		JGE		TEST_OPERATIONS

;------------------------Calculate the user's age--------------------------------------

;First, compare if u_month is less than or equal to current month(2)
;Second, compare if u_day is greater than current day(6)
;If FALSE, then jump to decrement instruction
;Age is current year(2015) minus u_year


;        mov     eax, number1    ; first number to EAX
;        add     eax, number2    ; add second number
;        dtoa    sum, eax        ; convert to ASCII characters
;        output  resultLbl, sum          ; output label and sum

		mov		eax, 2015
		sub		eax, u_year
		cmp		u_month, 2
		JGE		DAY_CALC
		JMP		DONE
DAY_CALC:
		cmp		u_day, 6
		JG		DECREMENT
		JMP		DONE
DECREMENT:
		dec		eax
DONE:
		dtoa	result, eax
		output	age_result, result
        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

