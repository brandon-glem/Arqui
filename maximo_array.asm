.data
arreglo: .word 7, 2, 69, 4, 8, 6, 119, 21, 26, 74

.text
main:
la $s1, arreglo # Cargar la direcci�n del arreglo en $s1
li $s2, 10 # Tama�o del arreglo

lw $t0, 0($s1)       # Cargar el primer elemento del arreglo como m�ximo
addi $t1, $zero, 0   # Inicializar el �ndice del arreglo a 0

loop:
add $t1, $t1, 1      # Incrementar el �ndice en 1
beq $t1, $s2, done   # Si se han examinado todos los elementos del arreglo, salir del ciclo

add $t2, $t1, $t1    # Multiplicar el �ndice por 2 y almacenar el resultado en $t2
add $t2, $t2, $t2    # Multiplicar el valor de $t2 por 2 y almacenar el resultado en $t2
add $t2, $t2, $s1    # Calcular la direcci�n del elemento del arreglo en $t2
lw $t3, 0($t2)       # Cargar el elemento del arreglo en $t3

slt $t4, $t0, $t3    # Comparar el elemento cargado con el m�ximo actual
beq $t4, $zero, loop # Si el elemento es menor o igual que el m�ximo actual, continuar con el siguiente elemento
addi $t0, $t3, 0     # Si el elemento es mayor que el m�ximo actual, actualizar el m�ximo actual
j loop               # Volver al inicio del ciclo

done:
li $v0, 1 # Cargar el c�digo de la syscall para imprimir un entero
move $a0, $t0 # Cargar el valor del m�ximo en $a0
syscall # Realizar la syscall para imprimir el m�ximo