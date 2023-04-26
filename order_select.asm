.data
arreglo: .word 7, 2, 69, 4, 8, 6, 119, 21, 26, 74
mensaje: .asciiz "El arreglo ordenado es:\n" # Mensaje a imprimir

.text
main:
la $s1, arreglo     # Cargar la direcci�n del arreglo en $s1
li $s2, 10          # Tama�o del arreglo
addi $t1, $zero, 0  # Inicializar el �ndice del arreglo a 0

outer_loop:
beq $t1, $s2, done  # Si se han examinado todos los elementos del arreglo, salir del ciclo

lw $t0, 0($s1)      # Cargar el primer elemento del subarreglo restante como m�ximo
add $t2, $s1, $t1   # Calcular la direcci�n del elemento actual en $t2

inner_loop:
addi $t1, $t1, 1    # Incrementar el �ndice en 1
beq $t1, $s2, swap  # Si se han examinado todos los elementos del subarreglo, hacer swap y continuar con el siguiente subarreglo

lw $t3, 0($t2)      # Cargar el elemento actual del subarreglo restante en $t3
sgt $t4, $t0, $t3   # Comparar el elemento cargado con el m�ximo actual
beq $t4, $zero, inner_loop # Si el elemento es menor o igual que el m�ximo actual, continuar con el siguiente elemento

move $t0, $t3       # Si el elemento es mayor que el m�ximo actual, actualizar el m�ximo actual
move $t5, $t2       # Guardar la direcci�n del m�ximo actual en $t5
j inner_loop        # Volver al inicio del ciclo interno

swap:
lw $t6, 0($s1)      # Cargar el primer elemento del subarreglo restante
lw $t7, 0($t5)      # Cargar el m�ximo actual
sw $t7, 0($s1)      # Hacer swap: guardar el m�ximo actual en la posici�n del primer elemento del subarreglo
sw $t6, 0($t5)      # guardar el primer elemento del subarreglo restante en la posici�n del m�ximo actual
addi $s2, $s2, -1   # Decrementar el tama�o del subarreglo restante en 1
addi $s1, $s1, 4    # Mover el puntero del subarreglo restante una posici�n hacia la derecha
addi $t1, $zero, 0  # Reinicializar el �ndice del subarreglo restante a 0
j outer_loop        # Volver al inicio del ciclo externo

done:
li $v0, 4           # Cargar el c�digo de la syscall para imprimir una cadena
la $a0, mensaje     # Cargar la direcci�n del mensaje en $a0
syscall             # Realizar la syscall para imprimir el mensaje

li $t1, 0           # Inicializar el �ndice del arreglo a 0

reverse_loop:
beq $t1, $s2, exit  # Si se han examinado todos los elementos del arreglo, salir del programa

sub $t5, $s2, $t1   # Calcular el �ndice del elemento actual en orden descendente
sll $t5, $t5, 2     # Multiplicar el �ndice por 4 para obtener la direcci�n del elemento
add $t5, $s1, $t5

lw $a0, 0($t5)      # Cargar el elemento actual del arreglo en $a0
li $v0, 1           # Cargar el c�digo de la syscall para imprimir un entero
syscall             # Imprimir el elemento actual del arreglo

addi $t1, $t1, 1    # Incrementar el �ndice del arreglo en 1
j reverse_loop      # Continuar con el siguiente elemento del arreglo en orden descendente

exit:
li $v0, 10 # Cargar el c�digo de la syscall para salir del programa
syscall # Salir del programa