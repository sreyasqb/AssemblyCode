org 100h
include 'emu8086.inc'

;question 1
.data
n1 db ?  
n2 db ?       
general db "ENTER 2 DIGIT NUMBER $"
string1 db "ENTER FIRST NUMBER : $"  
string2 db "ENTER SECOND NUMBER : $"
string db "ANSWER IS : $"
.code 
    
;GENERAL MESSAGE
LEA DX,general 
MOV AH,09H
INT 21H   

printn
printn  
    
    
    
;DISPLAYING FIRST MESSAGE         
LEA DX,STRING1 
MOV AH,09H
INT 21H  

;GETTING INPUT FOR FIRST NUMBER
mov ah,01h   ;getting 1st char input
int 21h
sub al,30h   ;converting ascii to integer
lea bx,n1    ;putting address of a_real in b
mov b. [bx],al  ;modifying value of a_real 

mov ah,01h
int 21h
sub al,30h    ;repeating the above step and getting the number
mov cl,al
mov al,n1 ;putting n1 value in ax so that finally can get the 8 bit number
mov ch,10d    ;putting 10h in ch so that we can do the 2 digit number multiplication
mul ch        ; finally getting the 8 bit value perfectly
add al,cl
lea bx,n1
mov b. [bx],al
printn
   
;DISPLAYING SECOND MESSAGE
LEA DX,string2 
MOV AH,09H
INT 21H

;GETTING INPUT FOR SECOND MESSAGE
mov ah,01h   ;getting 1st char input
int 21h
sub al,30h   ;converting ascii to integer
lea bx,n2    ;putting address of a_real in b
mov b. [bx],al  ;modifying value of a_real 

mov ah,01h
int 21h
sub al,30h    ;repeating the above step and getting the number
mov cl,al
mov al,n2 ;putting n1 value in ax so that finally can get the 8 bit number
mov ch,10d    ;putting 10h in ch so that we can do the 2 digit number multiplication
mul ch        ; finally getting the 8 bit value perfectly
add al,cl
lea bx,n2
mov b. [bx],al


call multiplication



multiplication proc
    mov al, n1
    mov bl, n2
    mov cl, bl 
    dec cl
    mov si, 1000h
    
    l1: 
    add al, n1
    jo exit
    mov [si],al
    inc si
    dec cl
    cmp cl, 0
    jne l1
    
    mov cl,al 
    multiplication endp
    jmp exit
 
 
exit:       

printn
  
LEA DX,string
MOV AH,09H
INT 21H   

mov al,cl
call print_num  


ret                 

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS               

END
