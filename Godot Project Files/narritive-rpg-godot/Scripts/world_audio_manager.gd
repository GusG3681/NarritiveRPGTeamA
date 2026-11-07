extends Node

@export var bg_music_player: AudioStreamPlayer
var current_car: String
var car_npc_state: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_car = AudioGlobal.current_car
	current_car = "starter"
	car_npc_state = AudioGlobal.current_car_npc
	car_npc_state = "hidden"
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_car != AudioGlobal.current_car:
		print(current_car)
		print( AudioGlobal.current_car)
		current_car = AudioGlobal.current_car
		update_music()
		
func update_music():
	var current_car_music: String = "TempMusic1"
	
	var pick_music: Dictionary = {
		"starter": {"revealed": "TempMusic1", "hidden": "TempMusic1"},
		"car1":    {"revealed": "TempMusic2", "hidden": "TempMusic2"}, # Wife Car
		"car2":    {"revealed": "DaughterRevealed", "hidden": "DaughterHidden"}, # Daughter Car
		"car3":    {"revealed": "TempMusic2", "hidden": "TempMusic2"}, # Son Car
		"back_car":  {"revealed": "TempMusic1", "hidden": "TempMusic1"},
		"front_car": {"revealed": "TempMusic1", "hidden": "TempMusic1"}
	}
	
	print(current_car)
	# Safely fetch the music track or trigger an error if the car/state doesn't exist
	if pick_music.has(current_car) and pick_music[current_car].has(car_npc_state):
		current_car_music = pick_music[current_car][car_npc_state]

	bg_music_player.get_stream_playback().switch_to_clip_by_name(current_car_music)
		
