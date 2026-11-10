extends CharacterBody2D

@export var SPEED = 1000

#tracks which way sprite is facing
var flip = 1

var can_move = true

func _physics_process(delta: float) -> void:
	if not can_move:
		return
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
	if velocity.x > 0 and flip == 0:
		flip = 1
		$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
	if velocity.x < 0 and flip == 1:
		flip = 0
		$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
	
	if velocity.length() == 0:
		$AnimatedSprite2D.play("Stand")
	else:
		$AnimatedSprite2D.play("Walk")
	move_and_slide()
