.data
firstMsg: .asciiz "Digite o número para o somatório: "

.text
addi $v0, $zero, 4 # Lê string
la $a0, firstMsg # a0 contem endereço de onde está a mensagem
syscall

addi $v0, $zero, 5 # Lê inteiro
syscall

add $t0, $v0, $zero # Guardando inteiro lido

add $t1, $zero, $zero # Zerando variável para o somatório
loop:
	sub $t0, $t0, 1 #Subtraindo 1 do valor lido (Primeiro valor menor que ele)
	beq $t0, $zero, fim
	add $t1, $t0, $t1
	j loop
	
fim:

add $a0, $t1, $zero
addi $v0, $zero, 1 # Imprime inteiro
syscall
addi $v0, $zero, 10 # Finaliza
syscall
