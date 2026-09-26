.global gcd
# a in %edi, b in %esi; result in %eax
gcd:
    cmpl $0, %esi     #b-0
    je .L1            #if b==0 go to L1
    movl %edi, %eax   #%eax = a
    cltd              #sign extend %eax to %edx:%eax
    idivl %esi        #a/b
    movl %esi, %edi   #%edi = b
    movl %edx, %esi   #%esi = a%b
    call gcd          #call gcd(b, a%b)
    ret


.L1:
    movl %edi, %eax #%eax = a
    ret


# greatest common divisor via Euclid's algorithm (recursive)
# int gcd(int a, int b){
#     if(b == 0)
#         return a;
#     /* recursive call */
#     return gcd(b, a % b);
# }
