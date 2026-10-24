extends CharacterBody2D

@export var SPEED = 1000

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Right"):
		velocity.x += 1
	if Input.is_action_pressed("Back"):
		velocity.y -= 1
	if Input.is_action_pressed("Forward"):
		velocity.y += 1
	velocity = velocity.normalized() * SPEED
	move_and_slide()
