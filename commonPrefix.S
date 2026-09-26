.global commonPrefix
# a in %rdi, b in %rsi; result (prefix length) in %eax
commonPrefix:
  movl $0, %edx                  #%rdx = n = 0
.L1:
  movb (%rdi, %rdx, 1), %cl      #%cl = a[n]
  movb (%rsi, %rdx, 1), %r8b     #%r8b = b[n]
  cmpb $0, %cl                   #a[n] - 0
  je .L0                         #if a[n]==0 go to L0
  cmpb %r8b, %cl                 #a[n]-b[n]
  jne .L0                        #if a[n]!=b[n] go to L0
  addl $1, %edx                  #n++
  jmp .L1                        #loop again

.L0:
  movl %edx, %eax                #%eax = n
  retq


# length of the longest common prefix of two null-terminated strings
# int commonPrefix(char *a, char *b){
#     int n = 0;
#     while(a[n] && a[n] == b[n])
#         n++;
#     return n;
# }
