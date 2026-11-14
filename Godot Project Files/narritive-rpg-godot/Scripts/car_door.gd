extends Node2D

var door_locks: Dictionary
var wanted_door: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_door_trigger_1_body_entered(body: Node2D) -> void:
	wanted_door = str(get_path()).substr(11)
	print(wanted_door)
	if door_locks[wanted_door] == true:
		if body.is_in_group('player') and $door/AnimationPlayer.is_playing() == false:
			$door/AnimationPlayer.play('open')


func _on_door_trigger_2_body_entered(body: Node2D) -> void:
	wanted_door = str(get_path()).substr(11)
	print(wanted_door)
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
