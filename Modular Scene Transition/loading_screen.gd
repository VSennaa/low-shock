extends CanvasLayer

signal loading_screen_ready
signal fade_out_completed

@export var transition_node: ColorRect

var circle_animation_time : float = 0.3

func _ready() -> void:
	if transition_node and transition_node.material:
		transition_node.material.set_shader_parameter("_Progress", 0.0)
	
	var tween = create_tween()
	tween.tween_method(set_progress_value, 0.0, 1.0, circle_animation_time)
	await tween.finished
	
	loading_screen_ready.emit()

func _on_progress_changed(new_value: float) -> void:
	# You can use this for a progress bar
	pass

func _on_load_finished() -> void:
	if transition_node and transition_node.material:
		var tween = create_tween()
		tween.tween_method(set_progress_value, 
						  transition_node.material.get_shader_parameter("_Progress"), 
						  0.0, circle_animation_time)
		await tween.finished
		fade_out_completed.emit()
		queue_free()

func set_progress_value(value: float) -> void:
	if transition_node and transition_node.material:
		transition_node.material.set_shader_parameter("_Progress", value)
