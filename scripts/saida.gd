extends Area2D

@export var caminho = "res://cenas/cena_test.tscn"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		SceneManager.load_scene(caminho)
