extends CharacterBody2D

@export var SPEED = 150

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Left"):
		position.x -= SPEED * delta
	if Input.is_action_pressed("Right"):
		position.x += SPEED * delta
	if Input.is_action_pressed("Back"):
		position.y -= SPEED * delta
	if Input.is_action_pressed("Forward"):
		position.y += SPEED * delta
	move_and_slide()
