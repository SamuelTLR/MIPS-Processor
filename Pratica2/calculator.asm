.data
msgMenu: .asciiz "\n------ Menu ------\n (1)Soma\n (2)Subtração\n (3)Multiplicação\n (4)Exponencial \n (5)Sair\nDigite qual opção deseja: "

firstNumber: .asciiz "Digite o primeiro número: "
secondNumber: .asciiz "Digite o segundo número: "
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
beq $t1, $t0, start # Sim, Então volta

addi $t2, $zero, 5 # v0 > 5?
slt $t0, $t2, $v0 # Sim, Então volta
beq $t1, $t0, start

addi $t0, $zero, 1
beq $v0, $t0, case1 # Case 1

addi $t0, $t0, 1
beq $v0, $t0, case2 # Case 2

addi $t0, $t0, 1
beq $v0, $t0, case3 # Case 3

addi $t0, $t0, 1
beq $v0, $t0, case4 # Case 4

addi $t0, $t0, 1
beq $v0, $t0, case5 # Case 5

case1:
jal getData
jal plusCode 
jal printResult
j start

case2: 
jal getData
jal subtractionCode
jal printResult
j start

case3:
jal getData
jal timesCode
jal printResult
j start

case4:
jal getData
jal exponentalCode
jal printResult
j start
case5: #Sair
j finaliza

plusCode:
add $a0, $t0, $t1 # n1 + n2 guardado em a0
jr $ra

subtractionCode:
sub $a0, $t0, $t1 # n1 - n2 guardado em a0
jr $ra

timesCode:
add $t2, $zero, $zero # Zerando variÃ¡vel para guardar o numero da sequencia
addi $a0, $zero, 0 # Zerando a variavel aoande fica o resultado

timesLoop:
beq $t1, $t2, timesFinal # Enquanto i diferente de n2
addi $t2, $t2, 1 #Variavel i
add $a0, $t0, $a0 # resultado += n1
j timesLoop
timesFinal:
jr $ra

exponentalCode:
add $t6, $zero, $ra
addi $t5, $zero, 1
add $t3, $t1, $zero
addi $t4, $zero, 1 # i do exponencial
add $t1, $t0, $zero #n2 = n1 para poder reutilizar o codigo de multiplicação

beq $t3, $t5, exceptionalFinal
add $t5, $zero, $zero
exponentialLoop:
beq $t3, $t4, exponentialFinal
jal timesCode
addi $t4, $t4, 1
add $t5, $a0, $zero
add $t0, $t5, $zero
j exponentialLoop
exponentialFinal:
add $a0, $t5, $zero
add $ra, $t6, $zero
jr $ra

exceptionalFinal:
add $a0, $t0, $zero
add $ra, $t6, $zero
jr $ra

getData:
addi $v0, $zero, 4 # Le string
la $a0, firstNumber # a0 contem endereÃ§o de onde estÃ¡ a mensagem
syscall

addi $v0, $zero, 5 # Le inteiro
syscall

add $t0, $v0, $zero #Guardando inteiro lido

addi $v0, $zero, 4 # Le uma string
la $a0, secondNumber
syscall

addi $v0, $zero, 5 #Le inteiro
syscall

add $t1, $v0, $zero  #Guardando inteiro lido
jr $ra

printResult:
addi $v0, $zero, 1 # Imprime inteiro
syscall
jr $ra

finaliza:
addi $v0, $zero, 10 # Finaliza
syscall

