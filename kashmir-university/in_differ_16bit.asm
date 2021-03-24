;DATE 18,03,2021
;AUTHOR KAISER,SAKHI

; b. Write a program that reads two 16-bit integers from keyboard (using INT 21H) and displays their
; difference (using INT 21H after doing necessary ASCII conversion).


DATA SEGMENT
    MSG1 DB 0DH,0AH,"ENTER FIRST NUMBER 16BIT : $"
    MSG2 DB 0DH,0AH,"ENTER SECOND NUMBER 16BIT : $"
    MSG3 DB 0DH,0AH,"THE DIFFERENCE IS  : $"

    N1 DW ?
    N2 DW ?
    DIF DW ?

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
        
        CMP AX,BX
        
        JLE SKIP1
        SUB AX, BX 
        MOV DIF, AX
        JMP USKIP1
        SKIP1:
        SUB BX,AX
        MOV DIF, BX
        USKIP1:

        
        
        
        MOV AX, 4C00H
        INT 21H

        
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

        PROC DISP_STR
            MOV AH, 09h
            INT 21H
            RET
        ENDP DISP_STR

        PROC READCHAR
            MOV AH, 01H
            INT 21H
            RET
        ENDP READCHAR
CODE ENDS
END START