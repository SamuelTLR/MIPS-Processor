.data
firstMsg: .asciiz "Sequencia de Fibonacci\nInforme um Número: "
secondMsg: .asciiz "A série de fibonacci para " 
thirdMsg: .asciiz " elementos é:\n"

.text

addi $v0, $zero, 4 #imprime string
la $a0, firstMsg
syscall

addi $v0, $zero, 5 #pega inteiro
syscall

add $s0, $v0, $zero
subi $sp, $sp, 4
sw $s0, 0($sp) #guardando valor

addi $s1, $zero, 1
addi $s2, $zero, 2
add $a0, $zero, $zero #zerar a0
jal Fibonacci

add $t1, $a0, $zero #Guarda valor retornado da funcao em t1
addi $v0, $zero, 4
la $a0, secondMsg
syscall

lw $a0, 0($sp)
addi $sp, $sp, 4

addi $v0, $zero, 1 #imprime inteiro
syscall 

addi $v0, $zero, 4
la $a0, thirdMsg
syscall

add $a0, $t1, $zero
addi $v0, $zero, 1 #imprime inteiro
syscall 

#finaliza
addi $v0, $zero, 10
syscall

Fibonacci:
beq $s0, $s1, caso1
beq $s0, $s2, caso2

subi $sp, $sp, 4
sw $ra, 0($sp)
subi $sp, $sp, 4
sw $s0, 0($sp)

subi $s0, $s0, 1
jal Fibonacci

lw $s0, 0($sp)
addi $sp, $sp, 4

subi $s0, $s0, 2
jal Fibonacci
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra

caso1:
add $a0, $s1, $a0
jr $ra

caso2:
add $a0, $s1, $a0
jr $ra