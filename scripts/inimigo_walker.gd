extends CharacterBody2D

@export var direcao: Vector2 = Vector2.RIGHT
@export var seguidor: bool = false
@export var velocidade: float = 200.0
@export var velocidade_perseguicao: float = 150.0

var posicao_anterior: Vector2
var jogador: Node2D = null
var seguindo: bool = false
var direcao_original: Vector2  # Guarda a direção original

func _ready():
	posicao_anterior = global_position
	direcao_original = direcao  # Salva a direção do export
	if seguidor:
		$anim_seguidor.visible = true
		$anim.visible = false

func _physics_process(delta):
	posicao_anterior = global_position
	
	if seguindo and jogador and is_instance_valid(jogador):
		# Modo perseguição
		var direcao_jogador = (jogador.global_position - global_position).normalized()
		velocity = direcao_jogador * velocidade_perseguicao
		move_and_slide()
		
	else:
		# Modo patrulha - usa a direção original
		velocity = direcao * velocidade
		move_and_slide()
		
		# Inverte se bater
		if global_position == posicao_anterior:
			print("Parou! Invertendo direção")
			direcao = -direcao

func _on_range_body_entered(body: Node2D) -> void:
	if seguidor and body.name == "player":
		jogador = body
		seguindo = true
		print("Perseguindo!")

func _on_range_body_exited(body: Node2D) -> void:
	if body.name == "player":
		seguindo = false
		jogador = null
		direcao = direcao_original  # Restaura a direção original
		print("Saiu do alcance. Voltando a patrulhar na direção original")


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.name == "area_shock":
		velocidade = 0.0
		velocidade_perseguicao = 0.0
		seguindo = false
		jogador = null
		seguidor = false
		$colision.set_deferred("disabled", false)
		$anim.play("die")
		$anim_seguidor.play("die")
		#deu um bug aqui mas to com preguiça
