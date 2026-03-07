extends Node
# variaveis globais, que todos os scripts conseguem acessar
# usando g.parametro ou g.função
var bateria = 100.0

func delay(time: float):
	return get_tree().create_timer(time).timeout
