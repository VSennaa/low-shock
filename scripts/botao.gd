extends Area2D

@export var num = 1.0

func _on_area_entered(area: Area2D) -> void:
	if area.name == "area_shock":
		# Emite o signal passando o num como parâmetro
		g.emit_signal("btn_shock",num)
