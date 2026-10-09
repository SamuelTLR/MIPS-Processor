.data
firstMsg: .asciiz "Informe um numero: "
secondMsg: .asciiz "Novos Valores de V: "
thirdMsg: .asciiz " "
vetor: .word 0:9

.text
la $t0, vetor
addi $s0, $zero, 10 #Guardando tamanho do vetor
add $t1, $zero, $zero #Variavel que vai andar pelo vetor
addi $t2, $zero, 4 #Variavel para andar pela memoria

loopLeitura:
	beq $t1, $s0, fimLeitura
	addi $v0, $zero, 4 # Lê string
	la $a0, firstMsg # a0 contem endereço de onde esta a mensagem
	syscall

	addi $v0, $zero, 5 # Lê inteiro
	syscall
	
	sw $v0, 0($t0)
	add $t0, $t0, $t2
	addi $t1, $t1, 1
	j loopLeitura
	
fimLeitura:
add $t1, $zero, 1 #Variavel que vai andar pelo vetor
add $t3, $zero, $zero #Variavel 2 que vai andar pelo vetor
addi $s1, $zero, 1 #Guarda o valor 1 para compara��o no beq

loopBubble:
la $t0, vetor
beq $t1, $s0, fim
add $t3, $zero, $zero
sub $t4, $s0, $t1          # limite de j
loopBubble2:
beq $t3, $t4, fimBubble
lw $t5, 0($t0) # vetor[j]
add $t0, $t0, $t2
lw $t6, 0($t0) # vetor[j+1]

sle $t7, $t6, $t5
beq $t7, $s1, fimBubble2

sw $t5, 0($t0)
sub $t0, $t0, $t2
sw $t6, 0($t0)
add $t0, $t0, $t2

fimBubble2:
addi $t3, $t3, 1 # j++
j loopBubble2

fimBubble:
addi $t1, $t1, 1 # i++
j loopBubble



fim:
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

