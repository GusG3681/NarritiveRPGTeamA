extends HSlider

@export var audio_bus_name: String

# More methods _ready() will be added when some audio is finished

func _on_value_changed(value: float) -> void:
	#placeholder for audiocontrol
	print(value)
