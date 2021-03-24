;DATE 18,03,2021
;AUTHOR KAISER,SAKHI

; Write a program that reads two 8-bit integers from keyboard (using INT 21H) and displays their
; multiplication result (using INT 21H after doing necessary ASCII conversion).    


; NOTE ALL IN HEX :)

DATA SEGMENT
    msg1 DB 0DH,0AH,"ENTER FIRST NUMBER : $"
    msg2 DB 0DH,0AH,"ENTER SECOND NUMBER : $"
    msg3 DB 0DH,0AH,"PRODUCT IS : $"

    num1 DB 00H 
    num2 DB 00H
    product DW 0000H

DATA ENDS



CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    START:
        MOV AX, DATA
        MOV DS, AX 
        
        LEA DX, msg1
        MOV AH, 09H
        INT 21H

        CALL READNUM
        ;NOW THE NUMBER IS IN AL 
        MOV num1, AL

        LEA DX, msg2
        MOV AH, 09H
        INT 21H

        CALL READNUM
        MOV num2, AL

        ;; AT THIS POINT WE HAVE 2 NUMBERS 
        MOV AH, num1

        MUL AH 
        
        MOV product, AX
        
        LEA SI, product
        LEA DX, msg3
        MOV AH, 09H
        INT 21H
        CALL PRINTNUM
                        
                        
        
        MOV AX, 4C00H
        INT 21H
                
                
                
                
                

    ;MY PROCEDURE TO READ 8 BIT NUMBER FROM THE KEYBORAD
    PROC READNUM

        ;; THIS SUBROUTINE WILL SAVE THE VALUE IN AL REG. AFTER READIN
        PUSH CX

        MOV AH, 01H
        INT 21H
        ;AT THIS POINT WE HAVE NUM IN AL

        SUB AL, 30H
        CMP AL, 09H

        JLE J1 ; JUMP IF LESS OR EQUAL 
        SUB AL, 07H
        J1:
        MOV CL, 04H ; COUNT FOR ROTATE INST.
        ROL AL, CL  ; INTERCHANGE THE NIBBLES
        MOV CH, AL

        ;; FOR SECOND DIGIT

        
        MOV AH, 01H
        INT 21H
        ;AT THIS POINT WE HAVE NUM IN AL

        SUB AL, 30H
        CMP AL, 09H

        JLE J2 ; JUMP IF LESS OR EQUAL 
        SUB AL, 07H
        J2:
        ADD AL,CH

        POP CX   
        RET
    ENDP READNUM

    PROC PRINTNUM
        ; WORK ON HIGHER BYTE
        MOV AL, [SI+1] ; LOAD THE HIGHER BYTE FIRST FROM THE MEM 
        ;NOTE HIGHER IS STORED ON HIGHER ADDRESS EX: 41 
        
        AND AL, 0F0H ; GET THE HIGHER NIBBLE 

        MOV CL, 04H  ; 
        ROL AL, CL   ; ROTATE LEFT TO INTERCHAGE THE NIBBLES

        ADD AL, 30H  ; ADD 30 ASCII

        CMP AL, 39H  ; IF IT WAS GREATER THAN 9, THEN ADD MORE 7, IF ITS IS A,B,C..F
        JLE J3
        ADD AL, 07
        J3:
        MOV AH, 02H ; TO DISPLAY CHAR
        MOV DL, AL
        INT 21H 

        ;NOW WORK ON LOWER NIBBLE

        MOV AL, [SI+1]
        AND AL, 0FH
        MOV CL, 04H  ; 
    
        ADD AL, 30H  ; ADD 30 ASCII

        CMP AL, 39H  ; IF IT WAS GREATER THAN 9, THEN ADD MORE 7, IF ITS IS A,B,C..F
        JLE J4
        ADD AL, 07
        J4:
        MOV AH, 02H ; TO DISPLAY CHAR
        MOV DL, AL
        INT 21H 

        ;************NOW WORK ON LOWER BYTE

         ; WORK ON HIGHER BYTE
        MOV AL, [SI] ; LOAD THE HIGHER BYTE FIRST FROM THE MEM 
        ;NOTE LOWER BYTE IS STORED IN LOWER ADDRESS EX:40
        AND AL, 0F0H ; GET THE HIGHER NIBBLE 

        MOV CL, 04H  ; 
        ROL AL, CL   ; ROTATE LEFT TO INTERCHAGE THE NIBBLES

        ADD AL, 30H  ; ADD 30 ASCII

        CMP AL, 39H  ; IF IT WAS GREATER THAN 9, THEN ADD MORE 7, IF ITS IS A,B,C..F
        JLE J5
        ADD AL, 07
        J5:
        MOV AH, 02H ; TO DISPLAY CHAR
        MOV DL, AL
        INT 21H 

        ;NOW WORK ON LOWER NIBBLE

        MOV AL, [SI]
        AND AL, 0FH
        MOV CL, 04H  ; 
    

        ADD AL, 30H  ; ADD 30 ASCII

        CMP AL, 39H  ; IF IT WAS GREATER THAN 9, THEN ADD MORE 7, IF ITS IS A,B,C..F
        JLE J6
        ADD AL, 07
        J6:
        MOV AH, 02H ; TO DISPLAY CHAR
        MOV DL, AL
        INT 21H 

        RET

    ENDP PRINTNUM

CODE ENDS
END START