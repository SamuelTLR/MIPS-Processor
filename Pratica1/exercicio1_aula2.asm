.data
firstMsg: .asciiz "Digite o primeiro número: "
secondMsg: .asciiz "Digite o segundo número: "

.text

addi $v0, $zero, 4 # Lê string
la $a0, firstMsg # a0 contem endereço de onde está a mensagem
syscall

addi $v0, $zero, 5 # Lê inteiro
syscall

add $t0, $v0, $zero #Guardando inteiro lido

addi $v0, $zero, 4 # Lê uma string
la $a0, secondMsg
syscall

addi $v0, $zero, 5 #Lê inteiro
syscall

add $t1, $v0, $zero

sub $t2, $t0, $t1
beq $t2, $zero, true

	add $a0, $zero, $zero
	addi $v0, $zero, 1 # Imprime inteiro
	syscall
	j fim
	
true:
	addi $a0, $zero, 1
	addi $v0, $zero, 1 # Imprime inteiro
	syscall
	
fim:
addi $v0, $zero, 10 # Finaliza
syscall