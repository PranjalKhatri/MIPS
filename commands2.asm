initialize:
    add     $t0    $zero  $zero
    add     $t6    $zero  $zero 
    lw      $t1    $t0   0000000000000001
    add     $t3    $t1   $zero
    lw      $t2    $t0   0000000000000010
loop:
    add     $t6    $t6   $t3
    add     $t3    $t3   $t1
    beq     $t3    $t2   0000000000000001
    beq     $t3    $t3   1111111111111100
    sw      $t6    $t0   0000000000000011
done: