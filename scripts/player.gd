extends CharacterBody2D

@export var speed = 200.0

func _physics_process(delta):
	if g.bateria <=0.0: return
	g.bateria = g.bateria - 0.2
	
	# uso
	if Input.is_action_just_pressed("uso") and g.bateria >= 10.0:
		$anim.play("shock")
		g.bateria = g.bateria - 10
		await g.delay(1) # espera um segundo pra executar a proxima linha
		$anim.play("idle")
	
	# debug
	$debug.text = str(int(g.bateria))
	
	# movimentação
	var input = Vector2.ZERO
	
	if Input.is_action_pressed("direita"):  input.x += 1
	if Input.is_action_pressed("esquerda"): input.x -= 1
	if Input.is_action_pressed("baixo"):    input.y += 1
	if Input.is_action_pressed("cima"):     input.y -= 1
	
	velocity = input.normalized() * speed
	move_and_slide()
