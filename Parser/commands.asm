	; initialize:
	; add $t0 $zero $zero
	; add $t6 $zero $zero
	; lw $t1 $t0 1
	; add $t3 $t1 $zero
	; lw $t2 $t0 2
	; loop:
	; add $t6 $t6 $t3
	; add $t3 $t3 $t1
	; beq $t3 $t2 1
	; j loop
	; sw $t6 $t0 3
	; done:


.word 0 0
.word 1 5
.word 2 1
.word 3 0

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

