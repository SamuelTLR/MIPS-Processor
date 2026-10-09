.data
firstMsg: .asciiz "Informe o Dividendo: "
secondMsg: .asciiz "Informe o Divisor: "
divMsg: .asciiz " / "
equalMsg: .asciiz " = "
quocienteMsg: .asciiz "(quociente)"
restoMsg: .asciiz "(resto)"
.text

addi $v0, $zero, 4 # Lê string
la $a0, firstMsg # a0 contem endereço de onde está a mensagem
syscall

addi $v0, $zero, 5 # Lê inteiro
syscall

add $s0, $v0, $zero # Dividendo


addi $v0, $zero, 4 # Lê string
la $a0, secondMsg # a0 contem endereço de onde está a mensagem
syscall

addi $v0, $zero, 5 # Lê inteiro
syscall

add $s1, $v0, $zero # Divisor


add $t0, $zero, $zero  # Quociente
add $t1, $s0, $zero # x

loop:
	slt $t2, $s1, $t1
	beq $s1, $t1, continue
	beq $t2, $zero, fim
	continue:
		sub $t1, $t1, $s1
		addi $t0, $t0, 1
		j loop
fim:
add $t3, $t1, $zero

add $a0, $zero, $s0
addi $v0, $zero, 1 # Imprime inteiro
syscall

addi $v0, $zero, 4 # Lê string
la $a0, divMsg # a0 contem endereço de onde está a mensagem
syscall

add $a0, $zero, $s1
addi $v0, $zero, 1 # Imprime inteiro
syscall

addi $v0, $zero, 4 # Lê string
la $a0, equalMsg # a0 contem endereço de onde está a mensagem
syscall

add $a0, $zero, $t0
addi $v0, $zero, 1 # Imprime inteiro
syscall

addi $v0, $zero, 4 # Lê string
la $a0, quocienteMsg # a0 contem endereço de onde está a mensagem
syscall

add $a0, $zero, $t3
addi $v0, $zero, 1 # Imprime inteiro
syscall

addi $v0, $zero, 4 # Lê string
la $a0, restoMsg # a0 contem endereço de onde está a mensagem
syscall

addi $v0, $zero, 10 # Finaliza
syscall

