;DATE 02,21,2021
;AUTHOR KAISER,SAKHI

;PROGRAM : TO DIVIDE A 8BIT NO. WITH 8BIT AND ALSO DISPLAY THE RESULT 



DATA SEGMENT
    msg1  DB  0DH,0AH,"The qoutient is :","$"
    msg2  DB  0DH,0AH,"The reminder is :","$"
    qont DB 00H  ;will be used to store the qoutient
    rem  DB 00H  ;will be used to store the reminder
DATA ENDS



CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
	START:
	
	MOV AX, DATA
	MOV DS, AX 
	
	MOV AX,0009H     ;mov 9 into ax, as we are going to use 16bit/8bit 
	MOV CL,05H       ;mov the divisor into cl
	DIV CL           ;div by CL, ie: 0009/05
	
	MOV qont, AL     ;AL got the qoutient -> store into mem
	MOV rem, AH      ;AH got the reminder -> store into mem
	
	MOV AX, 0900H    ;09h is a argument to the int21h , that means we want to display a string
	LEA DX, msg1     ;load the base address of the string inot dx
	INT 21H          ;now call the isr
	
	MOV AH, 02H      ;02h is an argument to int21 that means we want to display a char
	MOV DL,qont      ;mov qoutient into DL
	ADD DL, 30H      ;Add 30h to make it ASCII compitible
	INT 21H          ;call isr
	
	MOV AH, 09H      ;display another string
	LEA DX, msg2
	INT 21H
	
	MOV AH, 02H      ;display the reminder
	MOV DL, rem
	ADD DL, 30H
    INT 21H
    
	
	MOV AX, 4C00H    ; 4CH = end the program and 00H return code
	INT 21H                                                     
	
	;it took me more time to comment then to write the whole code :) , im lying ;)
	;i know i forget things, this is for my future self
CODE ENDS
	END START
                                    
                                    
                                    
; output : qont = 1 , reminder= 4
; qont*divisor+reminder = 9 -> 1*5+4 = 9                                   