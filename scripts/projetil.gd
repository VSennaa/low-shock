extends CharacterBody2D

@export var direcao: Vector2 = Vector2.RIGHT
@export var velocidade: float = 300.0

var posicao_anterior: Vector2

func _ready():
	posicao_anterior = global_position

func _physics_process(delta):
	posicao_anterior = global_position
	velocity = direcao * velocidade
	move_and_slide()
	
	# Remove se parou ou saiu da tela
	if global_position == posicao_anterior or not _na_tela():
		queue_free()

func _na_tela() -> bool:
	var tela = get_viewport().get_visible_rect()
	return global_position.x >= 0 and global_position.x <= tela.size.x and \
		   global_position.y >= 0 and global_position.y <= tela.size.y
