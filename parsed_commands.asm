lw  $t0 $zero 0      ; sum = 0
lw  $t1 $zero 1      ; N
lw  $t3 $zero 2      ; const 1
add $t2 $zero $t3    ; counter = 1
loop:
add $t0 $t0 $t2      ; sum += counter
add $t2 $t2 $t3      ; counter += 1
add $t4 $t2 $zero    ; temp = counter
beq $t2 $t1 1        ; if counter == N, break
j loop               ; else continue looping
jal print_result     ; simulate function call
print_result:
sw  $t0 $zero 4      ; store result at mem[4]
done:
