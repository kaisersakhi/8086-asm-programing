;DATE 02,23,2021
;AUTHOR KAISER,SAKHI

;Write a program that reads two 8-bit integers from keyboard (using INT 21H) and displays their
;sum (using INT 21H after doing necessary ASCII conversion)


DATA SEGMENT
    msg1 DB "ENTER FIRST NUM : $"
    msg2 DB 0AH,0DH,"ENTER SECOND NUM : $"
    msg3 DB 0AH,0DH,"THE DIFFERENCE IS : $"
    num1 DB 00H
    num2 DB 00h
    differ DB 00H    
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    START:
    MOV AX, DATA
    MOV DS, AX

    LEA DX, msg1
    MOV AH, 09H ; TO DISPLAY A STRING 
    INT 21H

    MOV AH, 01 ;TO READ A CHAR
    INT 21H

    ;HERE I HAVE FIRST NUM IN AL 
    ;SUBTRACT 30H FROM AL (ASCII VALUE)

    SUB AL, 30H
    MOV num1, AL


    ;*************** repeat for second num
    LEA DX, msg2
    MOV AH, 09H ; TO DISPLAY A STRING 
    INT 21H

    MOV AH, 01 ;TO READ A CHAR
    INT 21H

    SUB AL, 30H
    MOV num2, AL

    ;at this stage i have two numbers at 2 diffrent memory locations
    ;now, i'll use abs to find the difference btween them

    MOV AH, num1
    ; NUM2 IS ALREADY IN AL 
    
    CMP AH, AL

    JG skip
    SUB AL, AH
    MOV differ,AL
    JMP skip2

    skip:
    SUB AH, AL
    MOV differ, AH

    skip2:

    LEA DX, msg3
    MOV AH, 09H
    INT 21H


    MOV AH, 06H 
    MOV DL, differ
    ADD DL, 30H
    INT 21H

    MOV AX, 4C00H
    INT 21H







CODE ENDS
END START