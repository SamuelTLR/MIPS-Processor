.data
vetorMsg: .asciiz "Digite o tamanho do vetor: "
firstMsg: .asciiz "Informe um numero: "
secondMsg: .asciiz "Maximo Valor do Vetor: "
vetor: .word 0:25

.text
addi $v0, $zero, 4 # LÃª string
la $a0, vetorMsg # a0 contem endereÃ§o de onde esta a mensagem
syscall

addi $v0, $zero, 5
syscall

add $s0, $zero, $v0 #Guardando tamanho do vetor em s0

la $t0, vetor
add $t1, $zero, $zero #Variavel que vai andar pelo vetor
addi $t2, $zero, 4 #Variavel para andar pela memoria

loopLeitura:
	beq $t1, $s0, fimLeitura
	addi $v0, $zero, 4 # Le string
	la $a0, firstMsg # a0 contem endereÃ§o de onde esta a mensagem
	syscall

	addi $v0, $zero, 5 # Le inteiro
	syscall
	
	sw $v0, 0($t0)
	add $t0, $t0, $t2
	addi $t1, $t1, 1
	j loopLeitura
	
fimLeitura:
#Prepara chamada de vetor
la $t0, vetor
add $t1, $zero, 1 #Variavel que vai andar pelo vetor
add $t3, $zero, $s0 #Variavel que vai guardar o tamanho do vetor
add $t4, $zero, $zero #maxAnterior
addi $s1, $zero, 1 #Guarda o valor 1 para comparação no beq
jal maxVetor

Final:
	add $s2, $zero, $a0
	addi $v0, $zero, 4 # Le string
	la $a0, secondMsg # a0 contem endereÃ§o de onde esta a mensagem
	syscall
	
	add $a0, $zero, $s2
	addi $v0, $zero, 1 # Imprime inteiro
	syscall

	addi $v0, $zero, 10 # Imprime inteiro
	syscall
maxVetor:
beq $t3, $s1, caso1

subi $sp, $sp, 4 #Liberando espaço no stackPointer
sw $ra, 0($sp) #salvando ponto de volta

subi $sp, $sp, 4 #Liberando espaço no stackPointer
sw $t3, 0($sp) #salvando tamanho do vetor

subi $sp, $sp, 4 #Liberando espaço no stackPointer
sw $t0, 0($sp) #salvando posicao do vetor
 
add $t0, $t0, $t2
subi $t3, $t3, 1
jal maxVetor

add $t4, $a0, $zero #maxVetor = o valor retornado(a0)

lw $t0, 0($sp) #Recebendo posicao do vetor 
addi $sp, $sp, 4 #Tirando espaço no stackPointer

lw $t3, 0($sp) #Recebendo posicao do vetor 
addi $sp, $sp, 4 #Tirando espaço no stackPointer

lw $ra, 0($sp) #Recebendo posicao do vetor 
addi $sp, $sp, 4 #Tirando espaço no stackPointer

lw $t5, 0($t0) #Recebendo valor do vetor $t5 = V[n]
sle $t6, $t4, $t5
beq $t6, $zero, caso2
beq $t6, $s1, caso1

caso1:
lw $a0, 0($t0)
jr $ra

caso2:
add $a0, $zero, $t4
jr $ra