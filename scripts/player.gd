extends CharacterBody2D

@export var speed = 200.0
var usando_chock = false

func _ready() -> void:
	$area_shock/colision.set_deferred("disabled", true)

func _physics_process(delta):
	$debug.text = str(int(g.bateria))
	if g.bateria <=0.0 or usando_chock: return
	g.bateria = g.bateria - 0.01
	
	if Input.is_action_just_pressed("uso") and g.bateria >= 10.0:
		shock()
	
	var input = Vector2.ZERO
	if Input.is_action_pressed("direita"):  
		input.x += 1
		$anim.play("right")
	if Input.is_action_pressed("esquerda"): 
		input.x -= 1
		$anim.play("left")
	if Input.is_action_pressed("baixo"):    
		input.y += 1
		$anim.play("down")
	if Input.is_action_pressed("cima"):     
		input.y -= 1
		$anim.play("up")
	
	velocity = input.normalized() * speed
	move_and_slide()

func shock():
	$anim.play("idle")
	$area_shock/anim.play("default")
	$area_shock.visible = true
	$area_shock/colision.set_deferred("disabled", false)  # MUDANÇA AQUI
	g.bateria = g.bateria - 10
	usando_chock = true
	await g.delay(0.5)
	usando_chock = false
	$anim.play("idle")
	$area_shock.visible = false
	$area_shock/colision.set_deferred("disabled", true)   # MUDANÇA AQUI

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("machucar_jogador"):
		shock()  # Isso ainda pode causar erro, mas com set_deferred dentro do shock agora funciona
