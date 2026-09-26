.global area
# a in %edi, b in %esi, c in %edx; result in %eax
area:
    movl %edi, %ecx    #%ecx = p = a
    addl %esi, %ecx    #%ecx = p = a+b
    addl %edx, %ecx    #%ecx = p = a+b+c
    sarl $1, %ecx      #%ecx = (a + b + c)/2
    movl %ecx, %r8d    #%r8d = p
    subl %edi, %r8d    #%r8d = p-a
    movl %ecx, %r9d    #%r9d = p
    subl %esi, %r9d    #%r9d = p-b
    movl %ecx, %r10d    #%r10d = p
    subl %edx, %r10d    #%r10d = p-c
    imull %r8d, %ecx     #%ecx = p*(p-a)
    imull %r9d, %ecx     #%ecx = p*(p-a)*(p-b)
    imull %r10d, %ecx    #%ecx = p*(p-a)*(p-b)*(p-c)
    movl %ecx, %edi      #%edi = p*(p-a)*(p-b)*(p-c)
    call r_sqrt
    retq

.global r_sqrt
#x in %edi
r_sqrt:
    cmpl $0, %edi      #x-0
    jge .L1            #if x>=0 go to L1
    movl $-1, %eax     #%eax = -1
    retq

.L1:
    cmpl $2, %edi      #x-2
    jge .L2            #if x>=2 go to L2
    movl %edi, %eax    #%eax = x
    retq

.L2:
    pushq %rdi        #save original x
    shrl $2, %edi     #%edi = x>>2
    call r_sqrt       #calling r_sqrt(x>>2)
    shll $1, %eax     #eax = small_cand = r_sqrt(x >> 2) << 1
    movl %eax, %ecx   #%ecx = large_cand = small_cand = r_sqrt(x >> 2) << 1
    addl $1, %ecx     #%ecx = large_cand = small_cand+1
    movl %ecx, %r8d   #%r8d = large_cand
    imull %r8d, %r8d  #%r8d = large_cand^2
    popq %rdi         #restore original x
    cmpl %edi, %r8d   #large_cand^2 - x
    jle .L3           #if large_cand^2 <= x go to L3
    retq              #return small_cand

.L3:
    movl %ecx, %eax   #%eax = large_cand
    retq


# int area(int a, int b, int c){
#     int p = (a + b + c)/2;
#     p = p * (p-a) * (p-b) * (p-c);
#     return sqrt(p);
# }
# calculate recursively the square root of an int (in C)
# int r_sqrt(int x){
#    if(x < 0)
#        return -1;
#    if (x < 2)
#        return x;
#   /* recursive call */
#    int small_cand = r_sqrt(x >> 2) << 1;
#    int large_cand = small_cand + 1;
#    if (large_cand * large_cand > x)
#        return small_cand;
#    else
#        return large_cand;
# }
