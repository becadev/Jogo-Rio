# Fase 1 Jogo Rio
# Azul do fundo: 0x546c8f 
# Preto das paredes: 0x000000
# salva o fundo em outro lugar da memoria: 131084($8) 
# Cinza grades: 0xb4b4b4
# Registradores sendo usados cenario:
#			    $15 -> variaveis para loops
#			    $9 at� $14, $16 ate $20 -> cores
#			    $8, $7 e $6 -> espa�o na memoria
#			    $21 -> tamanho da tela
# Registradores utilizados p�s cen�rio:
#			    $16, $17, $18, $11, $12 --> cores blue
#			    $9 -> fundo/rastro
#			    $19, $20, $13, $14 -> teclas do jogo   		
.text
# O pass�ro branco tem que ser do tamanho do espa�o entre as paredes verdes, pra ele poder se locomover atr�s do blue
# pq o blue � menor que o pass�ro branco no filme

main:lui $8, 0x1001	   # fundo
     lui $7, 0x1001	   # muros e gaiolas com passaros
     # lui $6, 0x1001	   # gaiola com passaros
     ori $9, $0, 0x141d29  # Azul escuro
     ori $10, $0, 0x546d8f # muros
     ori $11, $0, 0xb4b4b4 # Cinza da gaiola
     ori $12, $0, 0xfea3b1 # passaro da gaiola (rosa)
     ori $13, $0, 0xfff201 # passaro da gaiola (amarelo)
     ori $14, $0, 0xa8e61d # passaro da gaiola (verde)
     ori $16, $0, 0xfffffe # branco
     ori $17, $0, 0x736c73 # bicos
     ori $18, $0, 0x9c5b3c # patas
     ori $19, $0, 0xff7e00 # passaro da gaiola (laranja)
     ori $20, $0, 0x2a3340 # azul escuro para detalhes
     
     addi $21, $0, 8192   # Tamanho da tela toda
     addi $15 $0 16
     
FundoAzul: # Pinta todo o fundo azul
      beq $21, $0, Murosf1
      sw $9, 0($8) 
      addi $8, $8, 4
      addi $21, $21, -1
      j FundoAzul
Murosf1: 
	addi $15 $0 512
	lui $8, 0x1001	   # muros e gaiolas com passaros
	# Contorno da tela
	parte_superior_inferior:
		beq $15 $0 fim_parte_superior_inferior
		sw $10 0($8)    # parte superior
		sw $20 512($8)  # parte superior sombra
		sw $20 31744($8)# parte inferior sombra
		sw $10 32256($8)# parte inferior
		addi $8 $8 4
		addi $15 $15 -4
		j parte_superior_inferior
	fim_parte_superior_inferior:
	lui $8, 0x1001
	addi $15 $0 92
	partes_laterais_p1:
		beq $15 $0 parte_laterais_p2
		sw $10 512($8)   # esq
		sw $20 516($8)   # esq sombra
		sw $20 1016($8)  # dir sombra
		sw $10 1020($8)  # dir
		addi $8 $8 512
		addi $15 $15 -4
		j partes_laterais_p1
	parte_laterais_p2:
	lui $8, 0x1001
	addi $15 $0 100
	partes_laterais_p22:
		beq $15 $0 fim_laterais
		sw $10 19456($8)  # esq
		sw $20 19460($8)  # esq sombra
		sw $20 19960($8)  # dir sombra
		sw $10 19964($8)  # dir
		addi $8 $8 512
		addi $15 $15 -4
		j partes_laterais_p22
	fim_laterais:
	lui $8, 0x1001
	addi $15 $0 24
	quadrados_muros:
		parte_sup_infer_quadrado:
			beq $15 $0 dentro_do_quadrado
			sw $10 3636($8) # Q1
			sw $10 5684($8)
			sw $10 4012($8) # Q2
			sw $10 6060($8)
			sw $10 28212($8)# Q3
			sw $10 26164($8)
			sw $10 26540($8)# Q4
			sw $10 28588($8) 
		
			addi $15 $15 -4
			addi $8 $8 4
			j parte_sup_infer_quadrado
	dentro_do_quadrado:
		lui $8, 0x1001
		addi $15 $0 24
	for_dentro_do_quadrado:
			beq $15 $0 parte_laterais_quadrado
			sw $20 4148($8) # Q1
			sw $20 4660($8) # Q1
			sw $20 5172($8) # Q1
			
			sw $20 4524($8) # Q2
			sw $20 5036($8) # Q2
			sw $20 5548($8) # Q2
			
			sw $20 26676($8)# Q3
			sw $20 27188($8)# Q3
			sw $20 27700($8)# Q3
			
			sw $20 27052($8)# Q4
			sw $20 27564($8)# Q4
			sw $20 28076($8)# Q4
			
			addi $15 $15 -4
			addi $8 $8 4
			j for_dentro_do_quadrado
	parte_laterais_quadrado:
		lui $8, 0x1001
		addi $15 $0 20
		for_laterais_quadrado:
			beq $15 $0 fim_quadrados
			sw $10 3632($8) # Q1
			sw $10 3660($8)
			
			sw $10 4008($8) # Q2
			sw $10 4036($8)
			
			sw $10 26188($8)# Q3
			sw $10 26160($8)
			
			sw $10 26536($8)# Q4
			sw $10 26564($8)
			
			addi $8 $8 512
			addi $15 $15 -4
			j for_laterais_quadrado
		fim_quadrados:
		lui $8, 0x1001
		addi $15 $0 48
obstaculo_entre_quadrados:
			beq $15 $0 jaula_central
			# 672 832
      			sw $10 124($8)    # parte de cima do L1
      			sw $10 372($8)    # parte de cima do L2
      			sw $10 26236($8)  # parte de baixo do L3
      			sw $10 26484($8)  # parte de baixo do L4
      			addi $8 $8 512
      			addi $15 $15 -4
      			j obstaculo_entre_quadrados
	jaula_central:
	lui $8, 0x1001
	addi $15 $0 20
	laterais_da_jaula: 
			beq $15 $0 fim_laterais_jaula
			sw $10 10876($8) # parte lateral esquerda da jaula 
			sw $10 10832($8) # parte lateral esquerda externa da jaula
			sw $10 11124($8) # parte lateral direita da jaula
			sw $10 11172($8) # parte lateral direita externa da jaula
			addi $8 $8 512
			addi $15 $15 -1
			j laterais_da_jaula
	fim_laterais_jaula:
	lui $8, 0x1001
	addi $15 $0 20
parte_superior_gaiola_central:
			beq $15 $0 fimparte_superior_gaiola_central
			sw $10 10880($8) # esquerda
			sw $10 5332($8)  # centro parte superior
			sw $10 11048($8) # direita
			sw $10 26836($8) # centro parte inferior
			addi $8 $8 4
			addi $15 $15 -1
			j parte_superior_gaiola_central
fimparte_superior_gaiola_central:
	lui $8, 0x1001
	addi $15 $0 63
parte_inferior_gaiola_central:
			beq $15 $0 fimgaiola_central
			sw $10 21116($8) # parte inferior jaula central
			addi $8 $8 4
			addi $15 $15 -1
			j parte_inferior_gaiola_central
fimgaiola_central:
	lui $8, 0x1001
	addi $15 $0 8
muro_frente_entrada_saida:
		beq $15 $0 fim_muros
		sw $10 15412($8)
		sw $10 15784($8)
		addi $8 $8 4
		addi $15 $15 -1
		j muro_frente_entrada_saida
fim_muros:
# gaiolas de passaros :|
	lui $8, 0x1001
# PASSARO ROSA
	ori $14, $0, 0xf77287 # detalhe passaro rosa
	sw $14 12424($8)# parte rosa da cabe�a1
	sw $12 12428($8)# parte rosa da cabe�a1
	sw $12 12432($8)# parte rosa da cabe�a1
	sw $12 12436($8)# parte rosa da cabe�a1
	sw $12 12440($8)# parte rosa da cabe�a1
	sw $12 12444($8)# parte rosa da cabe�a1
	sw $14 12940($8)# parte rosa da cabe�a2
	sw $12 12944($8)# parte rosa da cabe�a2
	sw $16 12948($8)# parte rosa da cabe�a2
	sw $17 12956($8)# parte rosa da cabe�a2
	sw $17 12960($8)# parte rosa da cabe�a2
	sw $14 13456($8)# parte rosa da cabe�a3
	sw $12 13460($8)# parte rosa da cabe�a3
	sw $12 13464($8)# parte rosa da cabe�a3
	sw $12 13468($8)# parte rosa da cabe�a3
	sw $17 13468($8)# parte rosa da cabe�a3
	sw $17 13472($8)# parte rosa da cabe�a3
	sw $14 13968($8)# parte rosa da cabe�a4
	sw $12 13972($8)# parte rosa da cabe�a4
	sw $12 13976($8)# parte rosa da cabe�a4
	sw $12 13980($8)# parte rosa da cabe�a4
	sw $14 14476($8)# parte rosa 5
	sw $12 14480($8)# parte rosa 5
	sw $12 14484($8)# parte rosa 5
	sw $12 14488($8)# parte rosa 5
	sw $12 14492($8)# parte rosa 5
	sw $14 14984($8)# parte rosa 6
	sw $12 14988($8)# parte rosa 6
	sw $12 14992($8)# parte rosa 6
	sw $12 14996($8)# parte rosa 6
	sw $12 15000($8)# parte rosa 6
	sw $12 15004($8)# parte rosa 6
	sw $14 15500($8)# parte rosa 7
	sw $12 15504($8)# parte rosa 7
	sw $12 15508($8)# parte rosa 7
	sw $12 15512($8)# parte rosa 7
	sw $12 15516($8)# parte rosa 7
	sw $18 16016($8)# pata
	sw $18 16024($8)# pata
# PASSARO AMARELO
	ori $14, $0, 0xd19a02 # detalhe passaro amarelo
	sw $13 17556($8)# parte cabe�a1
	sw $14 18064($8)# parte cabe�a1
	sw $13 18068($8)# parte cabe�a1
	sw $13 18072($8)# parte cabe�a1
	
	sw $14 18576($8)# parte amarela 2
	sw $16 18580($8)# parte branca olho
	sw $17 18588($8)# bico
	
	sw $14 19084($8)# parte amarela 3
	sw $13 19088($8)# parte amarela 3
	sw $13 19092($8)# parte amarela 3
	sw $13 19096($8)# parte amarela 3
	
	sw $14 19600($8)# parte amarela 4
	sw $13 19604($8)# parte amarela 4
	sw $13 19608($8)# parte amarela 4
	sw $18 20116($8)# pata
	
# PASSARO VERDE
	ori $14, $0, 0xa8e61d # passaro da gaiola (verde)
	ori $13, $0, 0x86b818 # detalhe passaro verde

	sw $14 12632($8) # parte verde 0
	sw $14 13140($8) # parte verde 1
	sw $14 13144($8) # parte verde 1
	sw $13 13148($8) # parte verde 1
	sw $17 13648($8)# bico
	sw $16 13656($8)# parte branca olho
	sw $13 13660($8) # parte verde 2
	sw $14 14164($8) # parte verde 3
	sw $14 14168($8) # parte verde 3
	sw $14 14172($8) # parte verde 3
	sw $13 14176($8) # parte verde 3
	sw $14 14676($8) # parte verde 4
	sw $14 14680($8) # parte verde 4
	sw $13 14684($8) # parte verde 4
	sw $18 15192($8) # pata
# PASSARO LARANJA
	ori $13, $0, 0xd16a06 # detalhe passaro laranja
	
	sw $19 16724($8) # parte laranja 1
	sw $19 16728($8) # parte laranja 1
	sw $19 16732($8) # parte laranja 1
	sw $13 16736($8) # parte laranja 1
	sw $13 16740($8) # parte laranja 1
	sw $13 17232($8) # bico
	sw $13 17236($8) # bico
	
	sw $13 17240($8) # parte branca olho
	sw $13 17244($8) # parte branca olho
	sw $13 17248($8) # parte laranja 2
	sw $17 17744($8) # bico
	sw $16 17752($8) # parte laranja 3
	sw $13 17756($8) # parte laranja 3
	sw $13 17760($8) # parte laranja 3
	sw $19 18260($8) # parte laranja 4
	sw $19 18264($8) # parte laranja 4
	sw $19 18268($8) # parte laranja 4
	sw $13 18272($8) # parte laranja 4
	sw $19 18768($8) # parte laranja 5
	sw $19 18772($8) # parte laranja 5
	sw $19 18776($8) # parte laranja 5
	sw $19 18780($8) # parte laranja 5
	sw $13 18784($8) # parte laranja 5
	sw $13 18788($8) # parte laranja 5
	sw $19 19280($8) # parte laranja 6
	sw $19 19284($8) # parte laranja 6
	sw $19 19288($8) # parte laranja 6
	sw $19 19292($8) # parte laranja 6
	sw $13 19296($8) # parte laranja 6
	sw $13 19300($8) # parte laranja 6
	sw $13 19304($8) # parte laranja 6
	sw $19 19792($8) # parte laranja 7
	sw $19 19796($8) # parte laranja 7
	sw $19 19800($8) # parte laranja 7
	sw $19 19804($8) # parte laranja 7
	sw $19 19808($8) # parte laranja 7
	sw $19 19812($8) # parte laranja 7
	sw $13 19816($8) # parte laranja 7
	
	sw $19 20308($8) # parte laranja 8
	sw $19 20312($8) # parte laranja 8
	sw $19 20316($8) # parte laranja 8
	sw $19 20320($8) # parte laranja 8
	
gaiolas_passaros:
	lui $8, 0x1001
	ori $11, $0, 0xb4b4b4 # Cinza da gaiola
	gaiola_1: # GAIOLA 1
		addi $15 $0 9
	for_gaiola1h:
		beq $15 $0 gaiola1h
		sw $11 11908($8)# superior
		sw $11 13956($8)# meio
		sw $11 16004($8)# inferior
		addi $8 $8 4
		addi $15 $15 -1
		j for_gaiola1h
	gaiola1h:
		lui $8, 0x1001
		addi $15 $0 9
	for_gaiola1v:
		beq $15 $0 gaiola1v
		sw $11 11908($8)# superior
		sw $11 11924($8)# meio
		sw $11 11944($8)# superior
		addi $8 $8 512
		addi $15 $15 -1
		j for_gaiola1v
	gaiola1v: # GAIOLA 1
		lui $8, 0x1001
		addi $15 $0 9
	gaiola1vv: 
		beq $15 $0 gaiola2
		sw $11 17028($8)# superior
		# sw $11 18052($8)# meio
		sw $11 19076($8)# meio
		sw $11 20612($8)# inferior
		addi $8 $8 4
		addi $15 $15 -1
		j gaiola1vv
	gaiola2:
		lui $8, 0x1001
		addi $15 $0 8
	gaiola2v:
		beq $15 $0 gaiola3
		sw $11 17028($8)# esquerdo
		sw $11 17044($8)# meio
		sw $11 17064($8)# direito
		addi $8 $8 512
		addi $15 $15 -1
		j gaiola2v
	gaiola3:
		lui $8, 0x1001
		addi $15 $0 9
	gaiola3h:
		beq $15 $0 gaiola3v
		sw $11 12104($8)   # supereior
		sw $11 14152($8)   # meio
		sw $11 15688($8)   # inferior
		addi $8 $8 4
		addi $15 $15 -1
		j gaiola3h
	gaiola3v:
		lui $8, 0x1001
		addi $15 $0 8
	gaiola3vv:
		beq $15 $0 gaiola4
		sw $11 12104($8)  # esq
		sw $11 12124($8)  # meio
		sw $11 12140($8)  # dir
		addi $8 $8 512
		addi $15 $15 -1
		j gaiola3vv
	gaiola4:
		lui $8, 0x1001
		addi $15 $0 10
	gaiola4h:
		beq $15 $0 gaiola4v
		sw $11 16712($8)   # superior
		sw $11 18760($8)   # meio
		sw $11 20808($8)   # inferior
		addi $8 $8 4
		addi $15 $15 -1
		j gaiola4h
	gaiola4v:
		lui $8, 0x1001
		addi $15 $0 8
	gaiola4vv:
		beq $15 $0 fimgaiolas
		sw $11 16712($8)   # superior
		sw $11 16732($8) # meio
		sw $11 16748($8)   # inferior
		addi $8 $8 512
		addi $15 $15 -1
		j gaiola4vv
	fimgaiolas:
# FRUTAS INICIO DE JOGO
	frutas:
	lui $8, 0x1001
	ori $12, $0, 0xed1c24 # vermelho morango
	ori $19, $0, 0xa11017 # vermelho degrade mais escuro
	ori $13, $0, 0xe34d55 # vermelho degrade mais claro
	
	# $14 -> verde para folhas
		morango:
			sw $19 3548($8)
			sw $14 3040($8) # folha
			sw $12 3552($8)
			sw $12 3556($8)
			sw $19 4056($8)
			sw $12 4060($8)
			sw $12 4064($8)
			sw $12 4068($8)
			sw $13 4072($8)
			sw $19 4568($8)
			sw $12 4572($8)
			sw $13 4576($8)
			sw $12 4580($8)
			sw $12 4584($8)
			sw $19 5084($8)
			sw $13 5088($8)
			sw $12 5092($8)
			sw $12 5600($8)

	frutass:
	lui $8, 0x1001
	# $13 -> amarelo, $18 -> cacho
	ori $13, $0, 0xf7f2ad # amarelo degrade mais claro
	ori $19, $0, 0xfff34d # amarelo normal
	ori $12, $0, 0xa89d03 # amarelo degrade mais escuro
		banana:
		
			sw $18 28192($8) # cacho
			sw $19 28700($8)
			sw $19 28704($8)
			sw $19 29208($8)
			sw $12 29212($8)
			sw $13 29216($8)
			sw $12 29712($8)
			sw $19 29716($8)
			sw $19 29720($8)
# MOVIMENTO DO BLUE
	dados_blue:
     		ori $17, $0, 0xb4b4b4 # bicos
     		ori $19, $0, 0xb4b4b4 # Cinza da gaiola
     		ori $9, $0,  0x141d29 # Cor de fundo para rastros
     		
     		ori $11, $0, 0x54cf0  # Azul claro blue
     		ori $12, $0, 0x333597 # Azul escuro blue
     		lui $8, 0x1001        # memoria do blue
     		lui $21 0xffff
     		
     		
     		addi $13 $0 'a' # move para a esquerda
     		addi $14 $0 's' # move para baixo
     		addi $20 $0 'w' # move para cima
     		addi $19 $0 'd' # move para a direita
     		addi $22 $0 ' ' # pausa tempor�ria
     		
     	desenho_blue:
     		sw $12 14348($8) # ponto azul
     		jal timerf1
		cv:lw $23 4($21)    # recupera da memoria se alguma tecla foi pressionada
		
	   	lw $24 14352($8)  # colisao frente
	   	beq $24 $10 colisao
		beq $24 $20 colisao
		beq $24 $19 colisao
		
		lw $24 14340($8)  # colisao atras
	   	beq $24 $10 colisao
		beq $24 $20 colisao
		beq $24 $19 colisao
		
		lw $24 13836($8)  # colisao abajo
	   	beq $24 $10 colisao
		beq $24 $20 colisao
		beq $24 $19 colisao
		
		lw $24 14860($8)  # colisao acima
	   	beq $24 $10 colisao
		beq $24 $20 colisao
		beq $24 $19 colisao
		
		lw $23 4($21)    # recupera da memoria se alguma tecla foi pressionada
		beq $23 $19 dir
		beq $23 $13 esq
		beq $23 $14 baixo
		beq $23 $20 cima
		beq $23 $22 fim
		# addi $8 $8 +4
		j desenho_blue
	dir:
		
     		addi $8 $8 +4
     		sw $9 14344($8)  # rastro esq
     		j desenho_blue
     		
     	esq:	
     		addi $8 $8 -4
     		sw $9 14352($8)  # rastro dir
     		j desenho_blue
     		
     	cima:	
		
     		addi $8 $8 -512
     		sw $9 14860($8)  # rastro baixo
     		j desenho_blue
     		
     	baixo:	
		
     		addi $8 $8 +512
     		sw $9 13836($8)  # rastro baixo
     		j desenho_blue
     	fim:
     		addi $2 $0 10
		syscall
colisao:
	j cv
##############################################################
# fun��o timer
timerf1:
	addi $15 $15 20000
	forT_f1:beq $15 $0 fimT_f1
		nop
		nop
		addi $15 $15 -1
		j forT_f1
	fimT_f1:
		jr $31
	
	
	

	