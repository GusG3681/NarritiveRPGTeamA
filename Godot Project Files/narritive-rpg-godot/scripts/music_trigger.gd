extends Area2D

@onready var musicplayer: AudioStreamPlayer = $AudioStreamPlayer
@export var fade_time: float = 1.0
@export var transition_type: float = 1.0
@export var normal_volume: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		musicplayer.play()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group('player'):
		musicplayer.stop()
