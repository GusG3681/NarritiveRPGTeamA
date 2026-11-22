extends Node2D

static var door_locks: Dictionary
var wanted_door: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

static var door_locks: Dictionary = {
	door_locks = {
		'locked_door' : false,
		'car_door0': true,
		'car_door1' : true,
		'car_door2' : false,
		'car_door3': false,
		'car_door4' : false,
		'car_door5' : false,
		'car_door6' : false,
	}
}
	
var wanted_door: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("doors")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func is_locked() -> bool:
	if not door_locks.has(name):
		return false
	return not door_locks[name]
	
func camera_stop_x() -> float:
	if has_node("CameraStop"):
		return $CameraStop.global_position.x
	return global_position.x

func _on_door_trigger_1_body_entered(body: Node2D) -> void:
	wanted_door = str(get_path()).substr(11)
	print(wanted_door)
	print(door_locks[wanted_door])
	if door_locks[wanted_door] == true:
		if body.is_in_group('player') and $door/AnimationPlayer.is_playing() == false:
			$door/AnimationPlayer.play('open')


func _on_door_trigger_2_body_entered(body: Node2D) -> void:
	wanted_door = str(get_path()).substr(11)
	print(wanted_door)
	print(door_locks[wanted_door])
	if door_locks[wanted_door] == true:
		if body.is_in_group('player') and $door/AnimationPlayer.is_playing() == false:
			$door/AnimationPlayer.play('open')


func _on_door_trigger_2_body_exited(body: Node2D) -> void:
	wanted_door = str(get_path()).substr(11)
	print(wanted_door)
	if door_locks[wanted_door] == true:
		if body.is_in_group('player') and $door/AnimationPlayer.is_playing() == false:
			$door/AnimationPlayer.play('close')


func _on_door_trigger_1_body_exited(body: Node2D) -> void:
	wanted_door = str(get_path()).substr(11)
	print(wanted_door)
	if door_locks[wanted_door] == true:
		if body.is_in_group('player') and $door/AnimationPlayer.is_playing() == false:
			$door/AnimationPlayer.play('close')
