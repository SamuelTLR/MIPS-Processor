.data
firstMsg: .asciiz "Digite um numero: "
resultMsg: .asciiz "Novo valor: "
.text

addi $v0, $zero, 4 # Lê string
la $a0, firstMsg # a0 contem endereço de onde esta a mensagem
syscall

leInteiro:
addi $v0, $zero, 5 # Lê inteiro
syscall

add $s0, $zero, $v0 #Guardando o valor de N em s0
addi $t0, $zero, 4
addi $s1, $zero, 1
addi $t2, $zero, 0 #Variavel que guarda a posicao do stackPointer

jal funcaoH
addi $v0, $zero, 4 # Lê string
la $a0, resultMsg # a0 contem endereço de onde esta a mensagem
syscall

add $a0, $s0, $zero
addi $v0, $zero, 1 # Imprime inteiro
syscall

addi $v0, $zero, 10
syscall

funcaoH:
sle $t1, $t0, $s0 # se 3 <= N t1 = 1 se nao (Sucesso) t1 = 0
beq $t1, $zero, return
beq $t1, $s1, case2
jr $ra
case2:
subi $sp, $sp, 4
sw $ra, 4($sp)
subi $s0, $s0, 4
jal funcaoH
add $a0, $s0, $s0 #salvando o resultado em $a0 * 2
addi $s0, $a0, 5 #s0 = a0 + 5
lw $ra, 4($sp)
addi $sp, $sp, 4
jr $ra


return:
add $t6, $s0, $s0
add $s0, $t6, $s0
jr $ra


