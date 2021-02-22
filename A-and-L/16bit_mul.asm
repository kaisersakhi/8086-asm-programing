DATA SEGMENT 
    num1 DW 0FFFFH
	num2 DW	0FFFFH
	product DD 0ABCDEF58H ;DUMMY DATA
DATA ENDS
;************

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    START:
    MOV AX, DATA
    MOV DS, AX
    MOV AX, num1
    MOV BX, num2
    MUL BX    
    MOV product, AX
    MOV [product+2], DX
    MOV AX, 4C00H
    INT 21H
CODE ENDS
    END START