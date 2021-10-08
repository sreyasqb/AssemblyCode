include 'emu8086.inc'

org 100h

.data
a_real dw ?
a_imag dw ?
b_real dw ?
b_imag dw ?    
a dw ?
b dw ?
Mgen db 'THESE ARE THE AVAILABLE OPERATIONS : $' 
Mexit db '0.Exit$'
Madd db '1.Addition $'
Msub db '2.Subtraction $'
Mmul db '3.multiplaction$'
Mdiv db '4.division $' 
Emess1 db 'WE WILL DO THE OPERATIONS ON COMPLEX NUMBERS$'        
Emess2 db 'ALL THE NUMBERS ARE IN A+iB FORMAT $'    
ARmess db 'ENTER 1st NUMBER REAL VALUE [A_REAL]: $'
AImess db 'ENTER 1st NUMBER IMAGINARY VALUE [A_IMAG]: $'
BRmess db 'ENTER 2nd NUMBER REAL VALUE [B_REAL]: $'
BImess db 'ENTER 2nd NUMBER IMAGINARY VALUE [B_IMAG]: $'  

 


.code
mov ax,@data    ;its kinda an unnecessary step but we still do it for good practice
mov ds,ax 


printn
lea dx,Emess1
mov ah,09h
int 21h         ;pretty programming thats all
printn
printn
lea dx,Emess2
mov ah,09h
int 21h
printn
printn  
      
whileloop:      
  
;ALL OF THIS IS TO GET a_real VALUE         



lea dx,ARmess
mov ah,09h
int 21h     
        
mov ah,01h   ;getting 1st char input
int 21h
sub al,30h   ;converting ascii to integer
lea bx,a_real    ;putting address of a_real in b
mov b. [bx],al  ;modifying value of a_real 

mov ah,01h
int 21h
sub al,30h    ;repeating the above step and getting the number
mov cl,al
mov ax,a_real ;putting a_real value in ax so that finally can get the 8 bit number
mov ch,10d    ;putting 10h in ch so that we can do the 2 digit number multiplication
mul ch        ; finally getting the 8 bit value perfectly
add al,cl
lea bx,a_real
mov b. [bx],al ;storing the value in a_real 

;ALL OF THIS IS TO GET a_imag VALUE
printn
lea dx,AImess
mov ah,09h
int 21h

mov ah,01h   ;getting 1st char input
int 21h
sub al,30h   ;converting ascii to integer
lea bx,a_imag    ;putting address of a_imag in b
mov b. [bx],al  ;modifying value of a_imag 

mov ah,01h
int 21h
sub al,30h    ;repeating the above step and getting the number
mov cl,al
mov ax,a_imag ;putting a_real value in ax so that finally can get the 8 bit number
mov ch,10d    ;putting 10h in ch so that we can do the 2 digit number multiplication
mul ch        ; finally getting the 8 bit value perfectly
add al,cl
lea bx,a_imag
mov b. [bx],al    

;ALL OF THIS IS TO GET b_real VALUE      
printn
printn
lea dx,BRmess
mov ah,09h
int 21h    
        
mov ah,01h   ;getting 1st char input
int 21h
sub al,30h   ;converting ascii to integer
lea bx,b_real    ;putting address of a_real in b
mov b. [bx],al  ;modifying value of a_real 

mov ah,01h
int 21h
sub al,30h    ;repeating the above step and getting the number
mov cl,al
mov ax,b_real ;putting a_real value in ax so that finally can get the 8 bit number
mov ch,10d    ;putting 10h in ch so that we can do the 2 digit number multiplication
mul ch        ; finally getting the 8 bit value perfectly
add al,cl
lea bx,b_real
mov b. [bx],al ;storing the value in a_real 

;ALL OF THIS IS TO GET a_imag VALUE
printn
lea dx,BImess
mov ah,09h
int 21h

mov ah,01h   ;getting 1st char input
int 21h
sub al,30h   ;converting ascii to integer
lea bx,b_imag    ;putting address of a_imag in b
mov b. [bx],al  ;modifying value of a_imag 

mov ah,01h
int 21h
sub al,30h    ;repeating the above step and getting the number
mov cl,al
mov ax,b_imag ;putting a_real value in ax so that finally can get the 8 bit number
mov ch,10d    ;putting 10h in ch so that we can do the 2 digit number multiplication
mul ch        ; finally getting the 8 bit value perfectly
add al,cl
lea bx,b_imag
mov b. [bx],al    
                 
;DISPLAYING GENERAL MESSAGE
printn
printn
lea dx,Mgen
mov ah,09h
int 21h



;SHOWING OPTIONS 

 
printn
printn   

lea dx,Mexit
mov ah,09h
int 21h     
printn

lea dx,Madd
mov ah,09h
int 21h     
printn

lea dx,Msub
mov ah,09h
int 21h
printn

lea dx,Mmul
mov ah,09h
int 21h 
printn   

lea dx,Mdiv
mov ah,09h
int 21h 
printn  

;ACCEPTING INPUT 
printn
printn
print 'ENTER YOUR VALUE HERE : '
mov ah,01h
int 21h
sub al,30h
            
;NOW IF INPUT==1 or addition   

cmp al,00h 
je exit_op 
    jmp add_label
    
    exit_op:
        jmp quit

add_label:
cmp al,01h
je addition
    jmp sub_label
    addition:
        mov ax,a_real     ;moving a_real into AX register
        add ax,b_real     ;adding value of AX(i.e value of a_real) with b_real
        printn
        printn
        print 'THE SUM OF THE TWO COMPLEX NUMBERS IS:'
        call print_num
        
        mov ax,a_imag     ;moving a_imag into AX register
        add ax,b_imag     ;adding value of AX(i.e value of a_imag) with b_imag
        
        ;printing in A+iB form  
        print '+ i ('     
        call print_num
        print ')'
      jmp stop
        


;IF INPUT==2 do subtraction 
sub_label:
cmp al,02h
je subtraction
    
    jmp mul_label
    subtraction:
        ;TYPE THE SUBTRACTION CODE HERE 
        mov ax, a_real
        sub ax, b_real
        printn
        printn
        print 'THE DIFFERENCE OF THE NUMBERS ARE : '
        call print_num
       
        mov ax, a_imag
        sub ax, b_imag    
        print ' + i ('
        call print_num
        print ')'
    jmp stop

;IF INPUT==3 do multiplaction    
mul_label:
cmp al,03h
je multiplication 
    
    jmp div_label
    multiplication:
        ;a+ib c+id multiplication=(ac-bd)+i(ad+bc)
 
        ;real part
        MOV AX,a_imag
        MOV BX,b_imag
        IMUL BX
        PUSH AX
        MOV AX,a_real
        MOV BX,b_real
        IMUL BX
        PUSH AX

        POP BX
        POP CX
        SUB BX,CX
        PUSH BX

       ;imaginary part
       MOV AX,a_real
       MOV BX,b_imag
       IMUL BX
       PUSH AX
       MOV AX,a_imag 
       MOV BX,b_real
       IMUL BX
       PUSH AX
       POP BX
       POP CX
       ADD BX,CX
       PUSH BX

       POP BX
       MOV b,BX
       POP AX
       MOV a,AX

       printn  ;print new line

       ;printing complex values after multiplication
       PRINT 'Your result after complex multiplication: '
       MOV AX,a
       CALL PRINT_NUM
       PRINT '+i'
       PRINT '('
       MOV AX,b
       CALL PRINT_NUM
       PRINT ')'  
       jmp stop
    
  



;IF INPUT==4 DO DIVISION 1 

div_label:
cmp al,04h
je divison
    
    divison: 
               ;formula is (ac+bd/c^2+d^2) + (bc-ad/c^2+d^2)   
    printn
    printn
    print 'THE RESULT OF DIVISION IS : ' 
    mov ax,a_real
    mul b_real
    mov cx,ax
    mov ax,a_imag
    mul b_imag
    add ax,cx
    call print_num   
    
    ;TO GET C^2+D^2
    mov ax,b_real
    mul ax
    mov bx,ax
    mov ax,b_imag
    mul ax
    add bx,ax
    mov ax,bx
    print '/'
    call print_num
    print ' + i('
    
    ;TO DO IMAG PART
    mov ax,a_imag
    mul b_real
    mov cx,ax
    mov ax,a_real
    mul b_imag
    sub cx,ax
    mov ax,cx
    call print_num   
    print '/'
    mov ax,bx
    call print_num
    print ')'   
    
;this is the stop label
stop:  
printn
printn
jmp whileloop  
quit:
   


 
ret

DEFINE_PRINT_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM_UNS

END