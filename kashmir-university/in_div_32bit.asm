;DATE 19,03,2021
;AUTHOR KAISER,SAKHI


; d. Write a program that reads two integers (32-bit and 16-bit) from keyboard (using INT 21H) and
; displays their division result (using INT 21H after doing necessary ASCII conversion).


DATA SEGMENT
    MSG1 DB 0DH,0AH,"ENTER FIRST NUMBER 32BIT : $"
    MSG2 DB 0DH,0AH,"ENTER SECOND NUMBER 16BIT : $"
    MSG3 DB 0DH,0AH,"THE QOUTIENT IS  : $"
    MSG4 DB 0DH,0AH,"AND, THE REMINDER IS :$"
    N1 DD ?
    N2 DW ?
    QOUT DW ?
    REM DW ?

DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

    START:
        MOV AX,DATA
        MOV DS, AX

        
        LEA DX, MSG1  ;DISPLAY 
        CALL DISP_STR ; ^
        
        ;READ THE HIGHER BYTE AND STORE INSIDE MEM AT HIGHER ADDRESS
        CALL READNUM
        MOV BYTE PTR [N1+3], AL
        ;READ ANOTHER BYTE
        CALL READNUM
        MOV BYTE PTR [N1+2], AL 
         ;READ ANOTHER BYTE
        CALL READNUM
        MOV BYTE PTR [N1+1], AL
         ;READ LAST BYTE
        CALL READNUM
        MOV BYTE PTR [N1], AL 
                    
        ;AT THIS POINT I GOT THE FULL DOUBLE WORD INSIDE THE MEMO , dividend

        LEA DX, MSG2  ;DISPLAY 
        CALL DISP_STR ; ^

        ;GET THE 16 DIVISOR  
        CALL READNUM
        MOV BYTE PTR [N2+1], AL
        CALL READNUM
        MOV BYTE PTR [N2], AL   


        ;AT THIS POINT I HAV BOTH DIVIDEND AND DIVISOR 
        ;TO DIVIDE I HAVE TO LOAD DD INTO DX AND AX
        ;DX FOR HIGHER BYTE AND AX FOR LOWER BYTE
        ; NOW LETS DIVIDE :)

        ;MOV LOWER WORD INTO AX
        MOV AX, WORD PTR N1
        ; MOV HIGHER WORD INTO DX
        MOV DX, WORD PTR [N1+2]

        ;NOW LOAD DIVISOR
        MOV BX, N2

        ; AT THIS POINT WE HAVE BOTH DIVIDEND AND DIVISOR 

        ;LETS DIVIDE
        DIV BX

        ;REMINDER IS IN DX
        ;QOUTIENT IS IN AX

        ;STORE QOUTIENT 

        MOV QOUT, AX
        MOV REM, DX

        LEA DX, MSG3 ; DISPLAY QOUT IS MESSAGE
        CALL DISP_STR
        ;DISPLAYED THE MESSAGE NOW DISPLAY QOUTIEN

        LEA SI, QOUT
        CALL PRINTNUM 
        
        ;NOW DISPLAY THE REMENDER MESG
        LEA DX, MSG4
        CALL DISP_STR
        
        LEA SI, REM
        CALL PRINTNUM
       
     
       
        
        MOV AX, 4C00H
        INT 21H
           
           
        ;START READ NUM SUBROUTINE
        PROC READNUM            
            
            CALL READCHAR 
            SUB AL, 30H 
            CMP AL, 09H

            JLE J1
            SUB AL,07H
            J1:
            MOV CL, 04H
            ROL AL, CL
            MOV CH, AL

            CALL READCHAR
            SUB AL, 30H 
            CMP AL, 09H

            JLE J2
            SUB AL,07H
            J2:
            ADD AL,CH
            RET
        ENDP READNUM 
        ;END READ NUM SBROUTINE 
             
        ;THIS WILL DISPLAY STRING 
        PROC DISP_STR
            MOV AH, 09h
            INT 21H
            RET
        ENDP DISP_STR
                                  
        ; THIS WILL READ CHAR FROM KEY                                  
        PROC READCHAR
            MOV AH, 01H
            INT 21H
            RET
        ENDP READCHAR


   ;START PRINTNUM PROCEDURE     

    PROC PRINTNUM
        ;READS 16BIT
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
    
    ;END PRINTNUM PROCEDURE
    
CODE ENDS
END START
