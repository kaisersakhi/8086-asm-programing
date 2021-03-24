;DATE 19,03,2021
;AUTHOR KAISER,SAKHI


; Write a program that reads two 16-bit integers from keyboard (using INT 21H) and displays their
; multiplication result (using INT 21H after doing necessary ASCII conversion).



DATA SEGMENT
    MSG1 DB 0DH,0AH,"ENTER FIRST NUMBER 16BIT : $"
    MSG2 DB 0DH,0AH,"ENTER SECOND NUMBER 16BIT : $"
    MSG3 DB 0DH,0AH,"THE PRODUCT IS  : $"

    N1 DW ?
    N2 DW ?
    PROD DD ?

DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

    START:
        MOV AX,DATA
        MOV DS, AX

        
        LEA DX, MSG1  ;DISPLAY 
        CALL DISP_STR ; ^

        CALL READNUM
        MOV BYTE PTR [N1+1], AL
        CALL READNUM
        MOV BYTE PTR [N1], AL 
                    

        LEA DX, MSG2  ;DISPLAY 
        CALL DISP_STR ; ^
                    
        CALL READNUM
        MOV BYTE PTR [N2+1], AL
        CALL READNUM
        MOV BYTE PTR [N2], AL   
        
        MOV AX, N1
        MOV BX, N2
        
        MUL BX
                      
        ;STORE THE RESULT IN PROD
        MOV WORD PTR PROD, AX
        MOV WORD PTR [PROD + 2], DX

        LEA DX, MSG3
        CALL DISP_STR           
        
        
        ; LOAD PROD AND DISP HIGHER WORD 
        LEA SI, WORD PTR [PROD+2]
        CALL PRINTNUM  
        ; LOAD PROD AND DISP LOWER WORD 
        LEA SI, WORD PTR [PROD]
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
