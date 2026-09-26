.global reverse
# list in %rdi (array of char*), n in %esi
reverse:
  movl $0, %edx                    #%edx = i = 0

.L1:
  movl %esi, %r10d                 #%r10d = n
  shrl $1, %r10d                   #%r10d = n/2
  cmpl %r10d, %edx                 #i-(n/2)
  jae .L2                          #if i>=(n/2) go to .L2
  movq (%rdi, %rdx, 8), %rcx       #%rcx = temp = list[i]
  movl %esi, %r8d                  #%r8d = n
  subl %edx, %r8d                  #%r8d = n-1
  subl $1, %r8d                    #%r8d = n-i-1
  movq (%rdi, %r8, 8), %r9         #%r9 = list[n-i-1]
  movq %r9, (%rdi, %rdx, 8)        #list[i] = list[n-i-1]
  movq %rcx, (%rdi, %r8, 8)        #list[n-i-1] = temp
  addl $1, %edx                    #i++
  jmp .L1                          #loop again

.L2:
  retq


# void reverse(char **list, unsigned n){
#     unsigned i = 0;
#     while (i < n/2){
#      char *temp = list[i];
#      list[i] = list[n-i-1];
#      list[n-i-1] = temp;
#      i++;
#     }
# }
