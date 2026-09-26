.global mult7div8
# a in %dil (signed char), overflow pointer in %rsi; result in %eax
mult7div8:
  movsbl %dil, %edx      #%edx = sign-extend a
  imull $7, %edx         #%edx = 7*a
  cmpb $0, %dil          #a-0
  jle .L1                #if a<=0 go to L1
  cmpb $0, %dl           #mult-0
  jge .L3                #if mult >=0 go to L3
  jmp .L2                #go to L2

.L1:
  cmpb $0, %dil          #a-0
  jge .L2                #if a>=0 go to L2
  cmpb $0, %dl           #mult-0
  jle .L3                #if mult<=0 go to L3

.L2:
  movb $1, (%rsi)        #(%rsi) = *overflow = 1
  jmp .L0                #go to L0

.L3:
  movb $0, (%rsi)        #(%rsi) = *overflow = 0

.L0:
  movsbl %dl, %eax       #%eax = mult
  cltd                   #sign extend %eax into %edx:%eax
  movl $8, %ecx          #%ecx = 8
  idivl %ecx             #%eax = mult/8
  retq


# char mult7div8(char a, char *overflow){
#     char mult = (7 * a);
#     if(a > 0 && mult < 0 || a < 0 && mult > 0)
#       *overflow = 1;
#     else
#       *overflow = 0;
#     return mult/8;
# }
