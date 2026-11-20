
.data
texto1: .asciiz "Digite o primeiro ano: "
texto2: .asciiz "Digite o segundo ano: "

texto_erro_iguais: .asciiz "\nErro: os anos devem ser diferentes. Digite novamente:\n"

texto_erro_diferenca: .asciiz "\nErro: a diferenca entre os anos nao pode ser maior que 1000. Digite novamente:\n"

texto_resultado: .asciiz "\nQuantidade de anos bissextos (incluindo os extremos): "

.text

main:

    # Inicializacao do contador de anos bissextos
    li $t2, 0

ler_anos:

    # Leitura do primeiro ano
    li $v0, 4
    la $a0, texto1
    syscall

    li $v0, 5
    syscall
    add $t0, $v0, $zero

    # Leitura do segundo ano
    li $v0, 4
    la $a0, texto2
    syscall

    li $v0, 5
    syscall
    add $t1, $v0, $zero

    # Verifica se os anos sao iguais
    beq $t0, $t1, anos_iguais

    # Identifica o maior e o menor ano
    bgt $t0, $t1, ano1_maior

    # Caso ano1 seja menor que ano2
    sub $t3, $t1, $t0
    add $t4, $t0, $zero
    add $t5, $t1, $zero
    j validar_diferenca

ano1_maior:

    sub $t3, $t0, $t1
    add $t4, $t1, $zero
    add $t5, $t0, $zero

validar_diferenca:

    # Verifica se a diferenca ultrapassa 1000
    li $t7, 1000
    bgt $t3, $t7, diferenca_invalida

    # Inicializa o ano atual com o menor ano
    # Assim, os extremos serao contabilizados
    add $t6, $t4, $zero
    j para

anos_iguais:

    li $v0, 4
    la $a0, texto_erro_iguais
    syscall

    j ler_anos

diferenca_invalida:

    li $v0, 4
    la $a0, texto_erro_diferenca
    syscall

    j ler_anos

# Estrutura de repeticao
para:

    # Encerra quando ultrapassar o maior ano
    bgt $t6, $t5, fim_para

    # Verifica divisibilidade por 400
    li $t7, 400
    rem $t8, $t6, $t7
    beq $t8, $zero, soma_qab

    # Verifica divisibilidade por 100
    li $t7, 100
    rem $t8, $t6, $t7
    beq $t8, $zero, proximo_ano

    # Verifica divisibilidade por 4
    li $t7, 4
    rem $t8, $t6, $t7
    bne $t8, $zero, proximo_ano

soma_qab:

    addi $t2, $t2, 1

proximo_ano:

    # Se chegou ao maior ano, encerra sem incrementar
    beq $t6, $t5, fim_para

    # Avanca para o proximo ano
    addi $t6, $t6, 1
    j para

fim_para:

    # Apresenta a quantidade de anos bissextos
    li $v0, 4
    la $a0, texto_resultado
    syscall

    li $v0, 1
    add $a0, $t2, $zero
    syscall

    # Encerra o programa
    li $v0, 10
    syscall
