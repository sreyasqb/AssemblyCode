include 'emu8086.inc'
org 100h

.DATA
pass db 50,50 dup (?)
passDup db 50,50 dup (?)  
uppercase db 0
lowercase db 0 
size db 0
symbols db 0                               
digits db 0
               
msg1 db "Enter the pass : $"
msg2 db "pass you have entered : $ "
                              
                
.CODE
;general message
lea dx,msg1
mov ah,09h
int 21h
                                                 
;getting input
lea dx,pass
mov ah,0ah
int 21h

;logic to store the pass in the string as we need to put $ at end
xor bx,bx
mov bl,pass[1]
mov pass[bx+2],"$"

printn  
;displaying pass
lea dx, msg2
mov ah, 09h
int 21h

lea dx,pass
add dx,2
mov ah,09h
int 21h         

;the function
call checkpass
ret



checkpass proc
    mov si,0h
    lea bx,pass 
    add bx,2
    mov size,0  
    
    mov uppercase,0
    
    
    traverse:
         cmp [bx+si],"$"
         je break
         cmp [bx+si],65
         jl goto2
         cmp [bx+si],90
         jg goto1
         add uppercase,1
         jmp goto4
         goto1:
         cmp [bx+si],97
         jl goto2
         cmp [bx+si],122
         jg goto2
         inc lowercase
         jmp goto4
         goto2:
         cmp [bx+si],48
         jl goto3
         cmp [bx+si],57
         jg goto3
         inc digits
         jmp goto4
         goto3:
         inc symbols    
         goto4:
         inc size
         inc si
    loop traverse
      
    break: 
                
    
    printn
     
    
    
    printn
    xor ax,ax
    printn "uppercase : "       
    mov al,uppercase
    call print_num
    
    printn
    
    
        
    xor ax,ax
    printn "special :"
    mov al,symbols
    call print_num
    printn
              
    printn "size :"
    xor ax,ax
    mov al,size
    call print_num   
            
    xor ax,ax
    printn "digits :"
    mov al,digits
    call print_num
    printn
    
    xor ax,ax
    printn "lowercase :"
    mov al,lowercase
    call print_num
    printn
    
    cmp uppercase,1
    jl invalid
    cmp size,8
    jl invalid

    cmp digits,1
    jl invalid  
    printn "PASSWORD IS VALID"
    
    
    printn "ENTER PASSWORD AGAIN"
    lea dx,passDup
    mov ah,0ah
    int 21h
    
    
    lea bx,pass
    
    mov si,0h
    add bx,2
    add dx,2
    
    confirmPass:
      xor ax,ax 
      lea bx,pass
      add bx,2   
      mov al,[bx+si] 
      cmp al,'$'
      je goto6
      lea bx,passDup
      add bx,2
      mov ah,[bx+si]   
      cmp al,ah
      jne notE
      inc si        
    loop confirmPass
    
    goto6:
    printn
    printn "YOU ARE GOOD TO GO!!!!"
    jmp goto5
    
    notE:       
    printn
    printn "WRONG PASSWORD TRY AGAIN :("
    jmp goto5
    
    invalid:    
    printn
    printn "INVALID"
    
    goto5:
    
    ret   
   
checkpass endp   
    


define_print_num
define_print_num_uns
end




