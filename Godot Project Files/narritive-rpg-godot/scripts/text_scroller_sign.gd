extends Node2D

@export var SPEED = 100
var maxTeleport = -200

@onready var text1 = $ScrollingText
@onready var text2 = $ScrollingText2
@onready var playerChar = get_parent().get_node("MainCharacter")

var width = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	width = text1.get_rect().size.x * abs(scale.x)
	text2.global_position.y = text1.global_position.y
	text2.global_position.x = text1.global_position.x - width
	maxTeleport = width


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	text2.global_position.x -= SPEED * delta
	text1.global_position.x -= SPEED * delta
	
	#too far behind, teleport forward
	if text2.global_position.x < -maxTeleport + playerChar.global_position.x:
		text2.global_position.x += width * 2
	if text1.global_position.x < -maxTeleport + playerChar.global_position.x:
		text1.global_position.x += width * 2
	
	#too far ahead, teleport behind
	if text2.global_position.x > maxTeleport + playerChar.global_position.x:
		text2.global_position.x -= width * 2
	if text1.global_position.x > maxTeleport + playerChar.global_position.x:
		text1.global_position.x -= width * 2
	
	#print(f"{text2.position.x}  pos: {position.x}   maxTeleport: {maxTeleport}    playerpos: {playerChar.position.x}")
	
