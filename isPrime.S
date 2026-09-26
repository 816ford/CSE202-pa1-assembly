.global isPrime
# n in %edi; result in %eax (1 = prime, 0 = not prime)
isPrime:
  cmpl $2, %edi     #n-2
  jge .L1           #if n<2 go to L1
  movl $0, %eax     #%eax = 0
  jmp .L0           #go to L0

.L1:
  testl $1, %edi    #n&1
  jne .L2           #if n%2 != 0 go to L2
  movl $0, %eax     #%eax=0
  cmpl $2, %edi     #n-2
  sete %al          #if n==2 %eax = 1
  jmp .L0           #go to L0

.L2:
  movl $3, %esi     #%esi = i = 3

.L3:
  movl %esi, %edx
  imull %edx, %edx          #%edx = i*i
  cmpl %edi, %edx           # i^2 - n
  jg .L5                    #if i^2 > n go to L5
  movl %edi, %eax           #%eax = n
  cltd                      #sign-extend %eax into %edx:%eax
  idivl %esi                #n/i
  cmpl $0, %edx             #%edx-0
  jne .L4                   #if %edx !=0 go to .L4
  movl $0, %eax             #%eax = 0
  jmp .L0                   #go to .L0

.L4:
  addl $2, %esi             #%esi = i+2
  jmp .L3                   #loop again

.L5:
  movl $1, %eax      #%eax = 1
  jmp .L0            #go to L0

.L0:
  ret


# int isPrime(int n){
#     if(n < 2)
#         return 0;
#     if(n % 2 == 0)
#         return n == 2;
#     /* only test odd divisors i while i*i <= n */
#     for(int i = 3; i * i <= n; i += 2){
#         if(n % i == 0)
#             return 0;
#     }
#     return 1;
# }
