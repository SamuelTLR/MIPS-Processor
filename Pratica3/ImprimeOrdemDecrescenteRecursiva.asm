.data
firstMsg: .asciiz "Informe um numero, para imprimir todos os numeros menores até 1: "
space: .asciiz " "
.text

addi $v0, $v0, 4
la $a0, firstMsg
syscall

addi $v0, $zero, 5
syscall

add $s0, $v0, $zero
jal impOrdemDecrescente

#finaliza
addi $v0, $zero, 10
syscall

impOrdemDecrescente:
sle $t1, $s0, $t0
subi $sp, $sp, 4
sw $ra, 0($sp)
beq $t1, $zero, caso1
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra

caso1:
add $a0, $s0, $zero
addi $v0, $zero, 1
syscall

addi $v0, $zero, 4
la $a0, space
syscall

subi $s0, $s0, 1
jal impOrdemDecrescente
