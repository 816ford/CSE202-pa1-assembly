.global sum
# pointer to list head in %rdi; result in %rax
# struct ll { char *name; long value; struct ll *next; }
#   offset 0  : name
#   offset 8  : value
#   offset 16 : next
sum:
    movq $0, %rax            #%rax = total = 0
    movq %rdi, %rsi          #%rsi = %rdi = pointer to list head
.L1:
    cmpq $0, %rsi            #%rsi - 0
    je .L0                   #if pointer to list = null go to L0
    addq 8(%rsi), %rax       #%rax = total + list.value
    movq 16(%rsi), %rsi      #%rsi = list.next
    jmp .L1                  #loop again



.L0:
    retq


# sum of the elements of a linkedlist in C
# long sum(struct ll *list){
#    long total = 0;
#    struct ll *ptr = list;
#    while(ptr){
#        total += ptr->value;
#        ptr = ptr->next;
#    }
#    return total;
# }
