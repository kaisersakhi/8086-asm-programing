DATA SEGMENT
	num DB 12H
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
	START:
		MOV AX, DATA
		MOV DS, AX
		MOV AL, num
		NOT AL
		MOV num, AL
		
		MOV AX, 4C00H
		INT 21H
CODE ENDS
	END START
