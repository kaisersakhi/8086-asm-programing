;DATE 18,03,2021
;AUTHOR KAISER,SAKHI

;Write a program that reads two 16-bit integers from keyboard (using INT 21H) and displays their
;sum (using INT 21H after doing necessary ASCII conversion).

DATA SEGMENT

    MSG1 DB 0DH,0AH,"ENTER 16BIT FIRST NUMBER : $"
    MSG2 DB 0DH,0AH,"ENTER 16BIT SECOND NUMBER : $"  
    MSG3 DB 0DH,0AH,"THE SUM IS : $"

    N1 DW ?
    N2 DW ?
    SUM DW ?

DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    START:
        MOV AX, DATA
        MOV DS, AX

        LEA DX, MSG1
        MOV AH,09H
        INT 21H

        CALL READNUM
        MOV BYTE PTR [N1+1], AL
        CALL READNUM
        MOV BYTE PTR N1, AL


        LEA DX, MSG2
        MOV AH,09H
        INT 21H

        CALL READNUM
        MOV BYTE PTR [N2+1], AL
        CALL READNUM
        MOV BYTE PTR N2, AL
            
        MOV AX, N2
        ADD AX, N1

        MOV SUM, AX


        LEA DX, MSG3
        MOV AH,09H
        INT 21H
        
        LEA SI, SUM
        CALL PRINTNUM 

        MOV AX, 4C00H
        INT 21H







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