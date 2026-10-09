.data
msgMenu: .asciiz "\n------ Menu ------\n(1)… igual?\n(2)SomatÛrio\n(3)Sequencia\n(4)Sair\nDigite qual opÁ„o deseja: "

sequenceMsg: .asciiz "Digite a quantidade de numeros da sequencia que deseja ver: "

somatoryMsg: .asciiz "Digite o numero para o somatorio: "

isEqualFirstMsg: .asciiz "Digite o primeio numero: "
isEqualSecondMsg: .asciiz "Digite o segundo numero: "

.text
start:
addi $v0, $zero, 4
la $a0, msgMenu #Imprime mensagem do Menu
syscall

addi $v0, $zero, 5
syscall

beq $v0, $zero, start # v0 == 0?
addi $t1, $zero, 1 #Inicializando variavel com 1

slt $t0, $v0, $zero # v0 < 0?
beq $t1, $t0, start # Sim, Ent„o volta

addi $t2, $zero, 4 # v0 > 4?
slt $t0, $t2, $v0 # Sim, Ent„o volta
beq $t1, $t0, start

addi $t0, $zero, 1
beq $v0, $t0, case1 # Case 1

addi $t0, $t0, 1
beq $v0, $t0, case2 # Case 2

addi $t0, $t0, 1
beq $v0, $t0, case3 # Case 3

addi $t0, $t0, 1
beq $v0, $t0, case4 # Case 4

case1:
addi $v0, $zero, 4 # Le string
la $a0, isEqualFirstMsg # a0 contem endere√ßo de onde est√° a mensagem
syscall

addi $v0, $zero, 5 # Le inteiro
syscall

add $t0, $v0, $zero #Guardando inteiro lido

addi $v0, $zero, 4 # Le uma string
la $a0, isEqualSecondMsg
syscall

addi $v0, $zero, 5 #Le inteiro
syscall

add $t1, $v0, $zero
jal isEqualCode
addi $v0, $zero, 1 # Imprime inteiro
syscall

j start

case2: 
addi $v0, $zero, 4 # Le string
la $a0, somatoryMsg # a0 contem endere√ßo de onde est√° a mensagem
syscall

addi $v0, $zero, 5 # Le inteiro
syscall

add $t0, $v0, $zero # Guardando inteiro lido
jal somatoryCode
addi $v0, $zero, 1 # Imprime inteiro
syscall
j start

case3:
addi $v0, $zero, 4 # L√™ string
la $a0, sequenceMsg # a0 contem endere√ßo de onde est√° a mensagem
syscall

addi $v0, $zero, 5 # L√™ inteiro
syscall

add $t0, $v0, $zero # Guardando inteiro lido

jal sequenceCode
addi $v0, $zero, 1 # Imprime inteiro
syscall

j start

case4: #Sair
j finaliza


isEqualCode:
sub $t2, $t0, $t1
beq $t2, $zero, isEqualTrue
	add $a0, $zero, $zero
	j isEqualFinal
	
isEqualTrue:
	addi $a0, $zero, 1
	
isEqualFinal:
jr $ra


somatoryCode:
add $t1, $zero, $zero # Zerando vari√°vel para o somat√≥rio
somatoryLoop:
	sub $t0, $t0, 1 #Subtraindo 1 do valor lido (Primeiro valor menor que ele)
	beq $t0, $zero, somatoryFinal
	add $t1, $t0, $t1
	j somatoryLoop
	
somatoryFinal:
add $a0, $t1, $zero
jr $ra

sequenceCode:
add $t1, $zero, $zero # Zerando vari√°vel para guardar o numero da sequencia

beq $t2, $t0, sequenceFinal
addi $t1, $zero, 1 #Variavel que guarda o numero da sequencia
addi $t2, $zero, 1 #Numero que gurda em qual numero da sequencia esta
beq $t2, $t0, sequenceFinal
addi $t1, $t1, 1 
addi $t2, $t2, 1 
sequenceLoop:
	beq $t2, $t0, sequenceFinal
	addi $t1, $t1, 2 
	addi $t2, $t2, 1 
	j sequenceLoop
sequenceFinal:
add $a0, $t1, $zero
jr $ra


finaliza:
addi $v0, $zero, 10 # Finaliza
syscall

