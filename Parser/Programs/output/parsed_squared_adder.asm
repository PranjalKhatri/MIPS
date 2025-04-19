lw $a0 $zero 1       # load N into $a0
lw $t7 $zero 2       # $t7 = 1 (constant 1)
lw $t6 $zero 3       # $t6 = -1 (constant -1)
jal sum_of_squares   # call function
sw $v0 $zero 0       # store result into memory[0]
j done               # halt
sum_of_squares:
add $t0 $zero $zero   # t0 = sum = 0
add $t1 $zero $zero   # t1 = i = 0
add $t2 $zero $a0     # t2 = N
sq_loop:
add $t1 $t1 $t7       # i++
add $t4 $zero $t1     # t4 = i (counter)
add $t5 $zero $zero   # t5 = i*i = 0
square_add_loop:
beq $t4 $zero 3       # if t4 == 0, jump to end_square
add $t5 $t5 $t1       # t5 += i
add $t4 $t4 $t6       # t4 -= 1
j square_add_loop
end_square:
add $t0 $t0 $t5       # sum += i*i
beq $t1 $t2 1         # if i == N, jump to end_sum
j sq_loop
end_sum:
add $v0 $zero $t0     # move sum to return value
jr $ra                # return
done:
j done                # infinite loop / halt
