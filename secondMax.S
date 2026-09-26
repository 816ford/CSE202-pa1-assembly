.global secondMax
# v1 in %di, v2 in %si, v3 in %dx, v4 in %cx  (signed 16-bit); result in %ax
secondMax:
  cmpw %si, %di    #v1-v2
  jge .L1          #if v1>=v2 go to .L1
  movw %si, %r8w   #%r8w = first = v2
  movw %di, %r9w   #%r9w = second = v1
  jmp .L2          #go to L2


.L1:
  movw %di, %r8w   #%r8w = first = v1
  movw %si, %r9w   #%r9w = second = v2

.L2:
  cmpw %r8w, %dx   #v3-first
  jg .L3           #if v3>first go to L3
  cmpw %r9w, %dx   #v3-second
  jg .L4           #if v3>second go to L4
  jmp .L5          #go to L5

.L3:
  movw %r8w, %r9w #%r9w = second = first
  movw %dx, %r8w  #%r8w = first = v3
  jmp .L5         #go to L5

.L4:
  movw %dx, %r9w  #%r9w = second = v3

.L5:
  cmpw %r8w, %cx  #v4-first
  jg .L6          #if v4>first go to L6
  cmpw %r9w, %cx  #v4-second
  jg .L7          #if v4>second go to L7
  jmp .L8         #go to L8

.L6:
  movw %r8w, %r9w #%r9w = second = first
  movw %cx, %r8w  #%r8w = first = v4
  jmp .L8         #go to L8

.L7:
  movw %cx, %r9w  #%r9w = second = v4

.L8:
  movw %r9w, %ax  #%ax = %r9w = second
  retq

# short secondMax(short v1, short v2, short v3, short v4){
#     short first, second;
#     if(v1 >= v2){ first = v1; second = v2; }
#     else        { first = v2; second = v1; }
#     if(v3 > first)       { second = first; first = v3; }
#     else if(v3 > second) { second = v3; }
#     if(v4 > first)       { second = first; first = v4; }
#     else if(v4 > second) { second = v4; }
#     return second;
# }
