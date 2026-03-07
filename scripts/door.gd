extends StaticBody2D

@export var num_necessario:int = 1
@export var fechado = true

func _ready():
	g.btn_shock.connect(btn_ativo)
	atualizar_estado()

func btn_ativo(num:int):
	if num == num_necessario:
		fechado = not fechado
		atualizar_estado()

func atualizar_estado():
	$anim.visible = fechado
	$colision.set_deferred("disabled", not fechado)
