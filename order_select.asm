.data
arreglo: .word 7, 2, 69, 4, 8, 6, 119, 21, 26, 74
mensaje: .asciiz "El arreglo ordenado es:\n" # Mensaje a imprimir

.text
main:
la $s1, arreglo     # Cargar la dirección del arreglo en $s1
li $s2, 10          # Tamaño del arreglo
addi $t1, $zero, 0  # Inicializar el índice del arreglo a 0

outer_loop:
beq $t1, $s2, done  # Si se han examinado todos los elementos del arreglo, salir del ciclo

lw $t0, 0($s1)      # Cargar el primer elemento del subarreglo restante como máximo
add $t2, $s1, $t1   # Calcular la dirección del elemento actual en $t2

inner_loop:
addi $t1, $t1, 1    # Incrementar el índice en 1
beq $t1, $s2, swap  # Si se han examinado todos los elementos del subarreglo, hacer swap y continuar con el siguiente subarreglo

lw $t3, 0($t2)      # Cargar el elemento actual del subarreglo restante en $t3
sgt $t4, $t0, $t3   # Comparar el elemento cargado con el máximo actual
beq $t4, $zero, inner_loop # Si el elemento es menor o igual que el máximo actual, continuar con el siguiente elemento

move $t0, $t3       # Si el elemento es mayor que el máximo actual, actualizar el máximo actual
move $t5, $t2       # Guardar la dirección del máximo actual en $t5
j inner_loop        # Volver al inicio del ciclo interno

swap:
lw $t6, 0($s1)      # Cargar el primer elemento del subarreglo restante
lw $t7, 0($t5)      # Cargar el máximo actual
sw $t7, 0($s1)      # Hacer swap: guardar el máximo actual en la posición del primer elemento del subarreglo
sw $t6, 0($t5)      # guardar el primer elemento del subarreglo restante en la posición del máximo actual
addi $s2, $s2, -1   # Decrementar el tamaño del subarreglo restante en 1
addi $s1, $s1, 4    # Mover el puntero del subarreglo restante una posición hacia la derecha
addi $t1, $zero, 0  # Reinicializar el índice del subarreglo restante a 0
j outer_loop        # Volver al inicio del ciclo externo

done:
li $v0, 4           # Cargar el código de la syscall para imprimir una cadena
la $a0, mensaje     # Cargar la dirección del mensaje en $a0
syscall             # Realizar la syscall para imprimir el mensaje

li $t1, 0           # Inicializar el índice del arreglo a 0

reverse_loop:
beq $t1, $s2, exit  # Si se han examinado todos los elementos del arreglo, salir del programa

sub $t5, $s2, $t1   # Calcular el índice del elemento actual en orden descendente
sll $t5, $t5, 2     # Multiplicar el índice por 4 para obtener la dirección del elemento
add $t5, $s1, $t5

lw $a0, 0($t5)      # Cargar el elemento actual del arreglo en $a0
li $v0, 1           # Cargar el código de la syscall para imprimir un entero
syscall             # Imprimir el elemento actual del arreglo

addi $t1, $t1, 1    # Incrementar el índice del arreglo en 1
j reverse_loop      # Continuar con el siguiente elemento del arreglo en orden descendente

exit:
li $v0, 10 # Cargar el código de la syscall para salir del programa
syscall # Salir del programa