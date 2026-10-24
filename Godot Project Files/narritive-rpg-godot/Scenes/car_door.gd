extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_door_trigger_1_body_entered(body: Node2D) -> void:
	if body.is_in_group('player') and $door/AnimationPlayer.is_playing() == false:
		$door/AnimationPlayer.play('open')


func _on_door_trigger_2_body_entered(body: Node2D) -> void:
	if body.is_in_group('player') and $door/AnimationPlayer.is_playing() == false:
		$door/AnimationPlayer.play('open')


func _on_door_trigger_2_body_exited(body: Node2D) -> void:
	if body.is_in_group('player') and $door/AnimationPlayer.is_playing() == false:
		$door/AnimationPlayer.play('close')


func _on_door_trigger_1_body_exited(body: Node2D) -> void:
	if body.is_in_group('player') and $door/AnimationPlayer.is_playing() == false:
		$door/AnimationPlayer.play('close')
