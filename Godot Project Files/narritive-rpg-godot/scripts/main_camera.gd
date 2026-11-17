extends Camera2D

@export var SPEED = 1.0

@onready var mainChar = $"../MainCharacter"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = _get_target_x()

func _get_target_x() -> float:
	var half_screen := get_viewport_rect().size.x / 2.0 / zoom.x
	var target: float = mainChar.position.x
	for door in get_tree().get_nodes_in_group("doors"):
		if not door.is_locked():
			continue
		if door.global_position.x < mainChar.global_position.x:
			continue
		var x: float = door.camera_stop_x()
		target = minf(target, x - half_screen)
	return target

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var posX = _get_target_x()
	var speedCalc = 1 / 10.0 / SPEED
	if abs(posX - position.x) > 2:
		position.x -= (position.x - posX) / speedCalc * delta
	await get_tree().create_timer(0.06).timeout
