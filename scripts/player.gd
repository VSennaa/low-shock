extends CharacterBody2D

@export var speed = 200.0
var usando_chock = false

func _ready() -> void:
	$area_shock/colision.disabled = true

func _physics_process(delta):
	if g.bateria <=0.0 or usando_chock: return
	g.bateria = g.bateria - 0.01
	
	# uso
	if Input.is_action_just_pressed("uso") and g.bateria >= 10.0:
		shock()
	
	# debug
	$debug.text = str(int(g.bateria))
	
	# movimentação
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
	$area_shock/colision.disabled = false
	g.bateria = g.bateria - 10
	usando_chock = true
	await g.delay(0.5) # espera um segundo pra executar a proxima linha
	usando_chock = false
	$anim.play("idle")
	$area_shock.visible = false
	$area_shock/colision.disabled = true
