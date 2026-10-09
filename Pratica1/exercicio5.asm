.data
firstMsg: .asciiz "Informe um número: "
secondMsg: .asciiz "Novos Valores de V: "
thirdMsg: .asciiz " "
vetor: .word 0:19

.text

la $t0, vetor
addi $s0, $zero, 20 #Guardando tamanho do vetor
add $t1, $zero, $zero #Variavel que vai andar pelo vetor
addi $t2, $zero, 4 #Variavel para andar pela memória

loop1:
	beq $t1, $s0, fim1
	addi $v0, $zero, 4 # Lê string
	la $a0, firstMsg # a0 contem endereço de onde está a mensagem
	syscall

	addi $v0, $zero, 5 # Lê inteiro
	syscall
	
	sw $v0, 0($t0)
	add $t0, $t0, $t2
	addi $t1, $t1, 1
	j loop1
fim1:

la $t0, vetor
add $t1, $zero, $zero # Guardado i = 0
add $t4, $zero, $zero # x = 0
lw $t5, 72($t0) #Guardando valor do vetor[n - 1]

loop2:
	beq $t1, $s0, fim2 # while(i < n)
	add $t4, $t4, $t5 #x = x + v[n-1]
	sw $t4, 0($t0) #v[i] = x
	add $t0, $t0, $t2 #i++
	addi $t1, $t1, 1
	j loop2

fim2:
addi $v0, $zero, 4 # Lê string
la $a0, secondMsg # a0 contem endereço de onde está a mensagem
syscall


la $t0, vetor
add $t1, $zero, $zero #Variavel que vai andar pelo vetor

loop3:
	beq $t1, $s0, fim3
	
	lw $a0, 0($t0)
	addi $v0, $zero, 1 # Imprime inteiro
	syscall
	
	addi $v0, $zero, 4 # Lê string
	la $a0, thirdMsg # a0 contem endereço de onde está a mensagem
	syscall
	
	add $t0, $t0, $t2
	addi $t1, $t1, 1
	j loop3
	
fim3:	
addi $v0, $zero, 10 # Finaliza
syscall

