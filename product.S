.global product
# a in %rdi, b in %rsi, c in %rdx, size in %ecx
product:
    movl $0, %r8d    #r8d = i = 0
.L1:
    cmpl %ecx, %r8d                  #i-size
    jae .L0                          #if i>=size go to .L0
    movss (%rdi, %r8, 4), %xmm0      #%xmm0 = a[i]
    movss (%rsi, %r8, 4), %xmm1      #%xmm1 = b[i]
    mulss %xmm1, %xmm0               #%xmm0 = a[i] * b[i]
    movss %xmm0, (%rdx, %r8, 4)      #c[i] = a[i]*b[i]
    addl $1, %r8d                    #i+=1
    jmp .L1                          #loop again


.L0:
    retq

# Product of two vectors in C
# void product(float *a, float *b, float *c, unsigned size){
#    for(int i=0; i<size; i++){
#        c[i] = a[i] * b[i];
#    }
# }
