    ;; save to s0 register the value 0
    ;add, $t0, $zero, $zero
    ;add, $t6, $zero, $zero
    ;;load in t1 the memory at address 8
    ;lw,  $t1,  $t0,  0000000000001000
    ;; jump one instructions forward
    ;j, 00000000000000000000000001
    ;;save at address 16
    ;sw, $t1,   $t0,  0000000000010000
    ;;save at address 32
    ;sw, $t1,   $t0,  0000000000100000

    ;jal , 00000000000000000000000001
initialize:
    add     $t0    $zero  $zero
    add     $t6    $zero  $zero 
    lw      $t1    $t0   1 ;lw $t1 1($t0)
    add     $t3    $t1   $zero
    lw      $t2    $t0   2
loop:
    add     $t6    $t6   $t3
    add     $t3    $t3   $t1
    beq     $t3    $t2   1
    beq     $t3    $t3   -4 
    sw      $t6    $t0   3
done:
; 0000000000000001
; 0000000000000010
; 0000000000000011