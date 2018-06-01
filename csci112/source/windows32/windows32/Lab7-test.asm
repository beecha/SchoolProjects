;Bee Cha
;CSCI 112, Lab 7
;Prompt user to enter 10 numbers
;The program will convert the numbers to DWORD using atod
;Then it will compare each DWORD element and sort them in ascending order
;Output the sorted array along with the original numbers
 
.586
.MODEL FLAT
INCLUDE io.h
.STACK 4096

.DATA
prompt1 BYTE "Enter ten scores (separated by a space each): ",0
prompt2 BYTE "output is: ",0
label1 BYTE "Original Scores:", 0 ;16 characters
label2 BYTE "Sorted Scores:", 0 ;14 characters
label3 BYTE "Results", 0
scoreString byte 40 dup(?),0; //for 10 scores - make enough room
sortString byte 140 dup(?),0;
outstr BYTE 400 dup(?), 0
scoreArray DWORD 10 dup (?)
temp byte 11 dup(?),0
tempx byte 11 dup(" "),0;     //or,..dup(20H); 20H=space
temp2 byte 11 dup(?),0
tempstr byte 11 dup(?),0
count1 dword 0
count2 dword -1

.CODE
_MainProc PROC
        input	prompt1, scoreString, 40; //prompt user to enter 10 scores
        lea ebx, scoreString
     
	    
 outerLoop: inc count1; //outer loop counter++

	;-----To put space, 20h, into the string-----;
        lea esi, tempx; //flush temp string before using
        lea edi, temp
        cld
        mov ecx, 11
        rep movsb		;put 11 20h into memory of &temp
        
        lea edx, temp;
 innerLoop: cmp byte ptr[ebx], 20h; //if ending mark(space), done, [ebx] is where the array is
        je done1; 
        cmp byte ptr[ebx], 00h;     //else if null char, also done, [ebx] is where the array is
        je done1;
        mov AL, byte ptr[ebx]; //otherwise, get 1 byte from input string
        mov [edx], AL;         //and move it to temp

        inc ebx;       //to next byte in input string
        inc edx;       //to next byte in temp string
        jmp innerLoop; //inner loop (temp <- one score)
        
 done1: ;output prompt2, temp; test display of temp 
        atod temp; //eax <- temp

        mov ecx, count1;
        dec ecx;       //counter:1 -> array index:0
        imul ecx, 4;   //array ele size = 4 bytes
        mov scoreArray[ecx], eax; //store one score in array
         
        inc ebx;       //skip the end mark(space) in the input string
        cmp count1, 10; //loop 10 times
        jnge outerLoop
        
        ;dtoa temp2, scoreArray[0]; or, scorearray+0; //testing display
        ;output  prompt2, temp2


;-----First, you must convert each ASCII element into DWORD-----;

	;get each element from the string and convert it to DWORD with atod
	;each element is separated by a space, 20h

		lea ebx, scoreString
outLoop:
		inc count2		;count2++

	;flush the contents in temp2 before using it again
		lea esi, tempx
		lea edi, temp2
		cld
		mov ecx, 11
		rep movsb

		lea	edx, temp2			;load the effective address of temp2 into edx register
inLoop:
		cmp	byte ptr [ebx], 20h	;compare if and when it will hit a space character in the string array
		je finish1
		cmp	byte ptr [ebx], 00h ;compare if and when it will hit a null character in the string array
		je finish1
		mov	al, byte ptr [ebx]	;otherwise get 1 byte from the string
		mov [edx], al			;move it to temp2
		;then grab the next byte
		inc	ebx
		inc edx
		jmp inLoop

finish1:
		atod temp2				;convert ascii value into DWORD type into eax register
		mov ecx, count2
		imul ecx, 4				;each DWORD size is 4 bytes
		mov	scoreArray[ecx], eax	;store the contents into scoreArray[0], scoreArray[4], and so on
		
		inc	ebx					;skip the initial 20h, go to next character in the string
		cmp	count2, 10
		jnge	outLoop			;loop 10 times for 10 elements
		

;-----Now perform the sorting algorithm-----;


	;Reset my counters
		mov	count1, -1	;count for outerloop
		mov	count2, 0	;count for innerloop

	;-----Selection Sort Algorithm-----;
	;outer loop: for (i = 0; i < 10, i++)
		;inner loop: for (j = i+1, j < 10, j++)
			;if a[j] < a[i]
				;swap (a[i], a[j])

	;scoreArray = [123, 45, 6, 777, 8, 20, 15, 35, 100, 50]

		lea ebx, scoreArray		;load starting address of scoreArray

sortOut:
		inc	count1
		mov	ecx, count1
		imul ecx, 4
		mov eax, dword ptr scoreArray[ecx]
		mov edi, count1
		mov count2, edi

sortIn:
		inc count2
		mov	esi, count2
		imul esi, 4
		mov	edx, dword ptr scoreArray[esi]
		cmp edx, eax
		;if edx is less than eax, exchange
		jl swap
		jmp skip
swap:
		xchg edx, eax		
		;after swapping, move it back into the array
		mov scoreArray[ecx], eax
		mov scoreArray[esi], edx

skip:
		cmp	count2, 8
		jng		sortIn

		cmp count1, 7
		jng		sortOut


;-----Append the sorted array to the a string and output result-----;

	;First, you must convert the sorted array into ASCII value using dtoa

		mov		count1, -1
		mov		count2, -1

stringCPY:
			;-----To put space, 20h, into the string-----;
        lea esi, tempx; //flush temp string before using
        lea edi, tempstr
        cld
        mov ecx, 11
        rep movsb		;put 11 20h into memory of &tempstr


		inc		count1
		inc		count2
		mov		ebx, count1
		imul	ebx, 4
		mov		eax, scoreArray[ebx]
		dtoa	tempstr, eax

		mov		edx, count2
		imul	edx, 11
		lea		edi, sortString[edx]
		lea		esi, tempstr
		cld
		mov		ecx, 11
		rep		movsb

		cmp		count1, 10
		jl		stringCPY


		;-----Append to String-----;

		lea		esi, label1
		lea		edi, outstr
		cld
		mov		ecx, 16
		rep		movsb

		lea		esi, scoreString
		lea		edi, outstr+16
		cld
		mov		ecx, 30
		rep		movsb
		
		mov		outstr+46, 0dh

		lea		esi, label2
		lea		edi, outstr+47
		cld
		mov		ecx, 14
		rep		movsb

		lea		esi, sortString
		lea		edi, outstr+61
		cld
		mov		ecx, 120
		rep		movsb

		output	label3, outstr

        mov     eax, 0
        ret
_MainProc ENDP
END

