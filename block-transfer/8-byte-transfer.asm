;DATE 02,23,2021
;AUTHOR KAISER,SAKHI

;PROGRAM , TO TRANSFER DATA FROM DATA SEGMENT INTO EXTRASEGMENT
;AND ALSO DISPLAY THE DATA FROM DS CHAR BY CHAR


EXTRA SEGMENT
	b1 DB 06H dup(00H)
	
EXTRA ENDS

DATA SEGMENT
	b2 DB 4BH,41H,49H,53H,45H,52H
	topaddr DB 00H
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA, ES:EXTRA
	START:
	MOV AX, DATA
	MOV DS, AX
	MOV AX, EXTRA
	MOV ES, AX
	
	LEA SI, b1
	LEA DI, b2

	MOV CX, 06H
	
	CLD
	REP MOVSB 
	

    
    LEA DI, b1 ; LOAD OFFSET ADDR OF B1 INTO SI
    MOV BL, 00H; BL TO COUNT
    MOV AH, 02H; ARGUMENT TO INT21 TO DISPLAY A CHAR
    BACK:
        MOV DL, [DI]  ;GET THE DATA FROM THE OFFSET
        ADD DI, 0001H ;INCREMENT SI BY 1
        INT 21H       ;CALL THE INT21
        MOV AL, 06    ;MOV 6 INTO AL
        SUB AL, BL    ;AL-BL IF THE RESULT IS ZERO THEN COUNT==N
        INC BL        ;INCREMENT COUNT
        ADD AL, 00H   ;ADD 0 TO AL TO CHECK IF THERE WAS A ZERO BEFORE INCREMENT, THEN ZERO FLAG WITLL BE 1
    JNZ BACK
    
	MOV AX, 4C00H
	INT 21H
	
CODE ENDS
	End START
