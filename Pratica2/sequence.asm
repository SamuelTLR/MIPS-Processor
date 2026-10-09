.data
firstMsg: .asciiz "Digite a quantidade de números da sequência que deseja ver: "

.text
.globl startSequence
startSequence:
addi $v0, $zero, 4 # Lê string
la $a0, firstMsg # a0 contem endereço de onde está a mensagem
syscall

addi $v0, $zero, 5 # Lê inteiro
syscall

add $t0, $v0, $zero # Guardando inteiro lido

add $t1, $zero, $zero # Zerando variável para guardar o numero da sequencia


beq $t2, $t0, fim
addi $t1, $zero, 1 #Variavel que guarda o numero da sequencia
addi $t2, $zero, 1 #Numero que gurda em qual numero da sequencia esta
beq $t2, $t0, fim
addi $t1, $t1, 1 
addi $t2, $t2, 1 
loop:
	beq $t2, $t0, fim
	addi $t1, $t1, 2 
	addi $t2, $t2, 1 
	j loop
	
fim:
add $a0, $t1, $zero
addi $v0, $zero, 1 # Imprime inteiro
syscall
addi $v0, $zero, 10 # Finaliza
syscall
