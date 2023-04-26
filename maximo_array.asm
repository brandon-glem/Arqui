.data
arreglo: .word 7, 2, 69, 4, 8, 6, 119, 21, 26, 74

.text
main:
la $s1, arreglo # Cargar la dirección del arreglo en $s1
li $s2, 10 # Tamaño del arreglo

lw $t0, 0($s1)       # Cargar el primer elemento del arreglo como máximo
addi $t1, $zero, 0   # Inicializar el índice del arreglo a 0

loop:
add $t1, $t1, 1      # Incrementar el índice en 1
beq $t1, $s2, done   # Si se han examinado todos los elementos del arreglo, salir del ciclo

add $t2, $t1, $t1    # Multiplicar el índice por 2 y almacenar el resultado en $t2
add $t2, $t2, $t2    # Multiplicar el valor de $t2 por 2 y almacenar el resultado en $t2
add $t2, $t2, $s1    # Calcular la dirección del elemento del arreglo en $t2
lw $t3, 0($t2)       # Cargar el elemento del arreglo en $t3

slt $t4, $t0, $t3    # Comparar el elemento cargado con el máximo actual
beq $t4, $zero, loop # Si el elemento es menor o igual que el máximo actual, continuar con el siguiente elemento
addi $t0, $t3, 0     # Si el elemento es mayor que el máximo actual, actualizar el máximo actual
j loop               # Volver al inicio del ciclo

done:
li $v0, 1 # Cargar el código de la syscall para imprimir un entero
move $a0, $t0 # Cargar el valor del máximo en $a0
syscall # Realizar la syscall para imprimir el máximo