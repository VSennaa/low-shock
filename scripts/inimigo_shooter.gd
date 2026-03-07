extends StaticBody2D

@export var projetil: PackedScene
@export var direcao_tiro: Vector2 = Vector2.RIGHT
@export var intervalo_tiro: float = 1.0
@export var velocidade_projetil: float = 300.0
@export var ativo: bool = true
@export var pode_tomar_shock : bool = false
@export var num_para_trocar_estado : int = 0 # 0 para não ter botão

func _ready():
	# Espera um frame antes de começar a atirar
	await get_tree().process_frame
	g.btn_shock.connect(btn_ativo)
	_start_atirar()

func _start_atirar():
	while ativo:
		_atirar()
		await get_tree().create_timer(intervalo_tiro).timeout

func _atirar():
	if projetil and $spawn:  # Verifica se o nó spawn existe
		var instancia = projetil.instantiate()
		get_parent().add_child(instancia)
		
		# Usa a posição GLOBAL do Marker2D $spawn
		instancia.global_position = $spawn.global_position
		
		if "direcao" in instancia:
			instancia.direcao = direcao_tiro
		if "velocidade" in instancia:
			instancia.velocidade = velocidade_projetil
		
		print("Tiro disparado de ", $spawn.global_position)
	else:
		print("Erro: Projétil ou nó spawn não encontrado!")


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if pode_tomar_shock and area.name == "area_shock":
		ativo = false
		
func btn_ativo(num:int):
	if num == num_para_trocar_estado:
		ativo = not ativo
