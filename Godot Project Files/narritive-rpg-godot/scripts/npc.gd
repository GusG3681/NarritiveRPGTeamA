extends Node2D

@export var speech = [
	"Hello there",
	"frick you"
	]

var curSpeech = 0

@onready var interaction_area: Area2D = $Area2D
var player_in_range = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.area_entered.connect(_on_area_entered)
	interaction_area.area_exited.connect(_on_area_exited)
	$Label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_in_range = true
		curSpeech = randi() % speech.size()
		$Label.text = speech[curSpeech]
		$Label.visible = true
		#print("entered")

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_in_range = false
		$Label.visible = false
		#print("exited")
