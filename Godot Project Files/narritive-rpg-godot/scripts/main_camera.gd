extends Camera2D

@export var SPEED = 1.0

@onready var mainChar = $"../MainCharacter"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = mainChar.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var posX = mainChar.position.x
	var speedCalc = 1 / 10.0 / SPEED
	if abs(posX - position.x) > 2:
		position.x -= (position.x - posX) / speedCalc * delta
	await get_tree().create_timer(0.06).timeout
