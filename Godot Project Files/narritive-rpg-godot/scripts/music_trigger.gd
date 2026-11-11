extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioGlobal.current_car = "starter"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _update_car() -> void:
	if str(get_node("..")).begins_with("car_starter"):
		AudioGlobal.current_car = "starter"
	elif str(get_node("..")).begins_with("car1"):
		AudioGlobal.current_car = "car1"
	elif str(get_node("..")).begins_with("car2"):
		AudioGlobal.current_car = "car2"
	elif str(get_node("..")).begins_with("car3"):
		AudioGlobal.current_car = "car3"
	elif str(get_node("..")).begins_with("front_car"):
		AudioGlobal.current_car = "front_car"
	elif str(get_node("..")).begins_with("back"):
		AudioGlobal.current_car = "back_car"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		_update_car()
		
