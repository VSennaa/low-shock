extends Label

@export_multiline var texto_dialogo: String = ""
@export var velocidade_letra: float = 0.02
@export var tempo_linha_vazia: float = 1.0
@export var tempo_entre_blocos: float = 1.5

var linhas: PackedStringArray
var linha_atual: int = 0

func _ready():
	# Configura o Label
	autowrap_mode = TextServer.AUTOWRAP_WORD
	custom_minimum_size.x = 500
	
	# Divide o texto em linhas
	linhas = texto_dialogo.split("\n")
	
	print("Diálogo carregado com ", linhas.size(), " linhas")
	
	# Começa o diálogo
	comecar_dialogo()

func comecar_dialogo():
	linha_atual = 0
	var texto_acumulado = ""
	
	while linha_atual < linhas.size():
		var linha = linhas[linha_atual]
		
		if linha == "":
			# Linha vazia: final do bloco atual
			print("Fim do bloco - pausando")
			await get_tree().create_timer(tempo_linha_vazia).timeout
			text = ""  # Apaga tudo
			texto_acumulado = ""  # Reseta o acumulador
			await get_tree().create_timer(tempo_entre_blocos).timeout
		else:
			# Mostra a nova linha (acumulando com as anteriores)
			texto_acumulado = await mostrar_linha(linha, texto_acumulado)
		
		linha_atual += 1
	
	print("Fim do diálogo!")

func mostrar_linha(texto: String, acumulado: String) -> String:
	# Se tem texto acumulado, adiciona uma quebra de linha
	if acumulado != "":
		text = acumulado + "\n"
	else:
		text = ""
	
	# Mostra a nova linha letra por letra
	for letra in texto:
		text += letra
		await get_tree().create_timer(velocidade_letra).timeout
	
	# Retorna o texto completo (acumulado + nova linha)
	return text
