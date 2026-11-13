extends Node2D

@export var image = preload("res://art/WindowBackground_Standard.png")
@export var SPEED = 1600
var maxTeleport = -200

@onready var background1 = $SubViewportContainer/SubViewport/Background1
@onready var background2 = $SubViewportContainer/SubViewport/Background2

var width = 100

func change_speed(s = 600, rate = 1) -> void:
	while abs(SPEED - s) > rate:
		SPEED -= abs(SPEED - s) / (SPEED - s) * rate
		await get_tree().create_timer(0.05).timeout
	SPEED = s

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background1.texture = image
	background2.texture = image
	background2.flip_h = true
	width = background1.get_rect().size.x * abs(background1.scale.x)
	background2.position.y = background1.position.y
	background2.position.x = background1.position.x + width
	maxTeleport = width


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	background2.position.x += SPEED * delta
	background1.position.x += SPEED * delta
	
	#too far behind, teleport forward
	if background2.position.x < -maxTeleport:
		background2.position.x += width * 2
	if background1.position.x < -maxTeleport:
		background1.position.x += width * 2
	
	#too far ahead, teleport behind
	if background2.position.x > maxTeleport:
		background2.position.x -= width * 2
	if background1.position.x > maxTeleport:
		background1.position.x -= width * 2
	
	#print(f"{text2.position.x}  pos: {position.x}   maxTeleport: {maxTeleport}    playerpos: {playerChar.position.x}")
	
