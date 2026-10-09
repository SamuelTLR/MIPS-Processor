.data
vetor: .word  0:2
firstMsg: .asciiz "Digite o primeiro número: "
secondMsg: .asciiz "Digite o segundo número: "
thirdMsg: .asciiz "Digite o terceiro número: "

.text

#pegando primeiro valor
addi $v0, $zero, 4 # Le string
la $a0, firstMsg # a0 contem endereço de onde está a mensagem
syscall

addi $v0, $zero, 5 # Le inteiro
syscall

add $t0, $v0, $zero #Guardando inteiro lido

#salvando no vetor
la $t1, vetor #Carregando endereço do vetor
sw $t0, 0($t1)


#pegando segundo valor
addi $v0, $zero, 4 # Lê uma string
la $a0, secondMsg
syscall

addi $v0, $zero, 5 #Lê inteiro
syscall

add $t0, $v0, $zero #Guardando inteiro lido

#Salvando no vetor
sw $t0, 4($t1)

#pegando terceiro valor
addi $v0, $zero, 4 # Lê uma string
la $a0, secondMsg
syscall

addi $v0, $zero, 5 #Lê inteiro
syscall

add $t0, $v0, $zero #Guardando inteiro lido

#Salvando no vetor
sw $t0, 8($t1)

lw $t2, 0($t1) # Pegando o primeiro valor do vetor
lw $t3, 8($t1) # Pegando o terceiro valor do vetor

sw $t2, 8($t1) #Salvando o primeiro valor no v[2]
sw $t3, 0($t1) #Salvando o terceiro valor no v[0]

lw $a0, 8($t1) #Lendo o terceio valor
addi $v0, $zero, 1 # Imprime inteiro
syscall
addi $v0, $zero, 10 # Finaliza
syscall
