.global binsearch
# arr in %rdi, n in %esi, target in %edx
binsearch:
  movl $0, %eax             # %eax = lo = 0
  movl %esi, %ecx            # %ecx = hi = n
  subl $1, %ecx             # %ecx = hi = n - 1

.L1:
  cmpl %eax, %ecx             # lo - hi
  jl .L2                      # if lo > hi, exit loop
  movl %ecx, %ebx             # %ebx = mid = hi
  subl %eax, %ebx             # %ebx = mid = hi - lo
  sarl $1, %ebx               # %ebx = mid = (hi - lo) / 2
  addl %eax, %ebx             # %ebx = mid = lo + (hi - lo) / 2
  movl (%rdi,%rbx,4), %esi    # %esi = arr[mid]
  cmpl %edx, %esi             # arr[mid] - target
  je .L3                      # if arr[mid] ==  target, return mid
  jl .L4                      # if arr[mid] < target, lo = mid + 1
  subl $1, %ebx               # hi = mid - 1
  movl %ebx, %ecx             # hi = mid - 1
  jmp .L1                     # continue loop

.L3:
  movl %ebx, %eax             # return mid
  ret

.L4:
  addl $1, %ebx               # lo = mid + 1
  movl %ebx, %eax             # lo = mid + 1
  jmp .L1                     # continue loop


.L2:
  movl $-1, %eax             # return -1
  ret


# binary search over a sorted int array; returns the index of target, or -1
# int binsearch(int *arr, unsigned n, int target){
#     int lo = 0;
#     int hi = (int)n - 1;
#     while(lo <= hi){
#         int mid = lo + (hi - lo) / 2;
#         if(arr[mid] == target)
#             return mid;
#         else if(arr[mid] < target)
#             lo = mid + 1;
#         else
#             hi = mid - 1;
#     }
#     return -1;
# }
