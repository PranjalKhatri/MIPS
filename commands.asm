//// save to s0 register the value 0
//add, $t0, $zero, $zero
//add, $t6, $zero, $zero
////load in t1 the memory at address 8
//lw,  $t1,  $t0,  0000000000001000
//// jump one instructions forward
//j, 00000000000000000000000001
////save at address 16
//sw, $t1,   $t0,  0000000000010000
////save at address 32
//sw, $t1,   $t0,  0000000000100000

jal , 00000000000000000000000001