DATA SEGMENT
	num1 DB 0FFH
	num2 DB	0FFH
	product DW 0000H
DATA ENDS
	
CODE SEGMENT
	ASSUME CD:CODE, DS:DATA
	START:
	MOV AX, DATA
	MOV DS, AX
	MOV AL, num1
	MOV BL, num2
	MUL BL
	MOV product, AX
	MOV AX, 4C00H
	INT 21H
CODE ENDS
	END START
