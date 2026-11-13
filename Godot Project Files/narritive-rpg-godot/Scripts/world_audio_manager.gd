extends Node

@export var bg_music_player: AudioStreamPlayer
var current_car: String
var car_npc_state: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_car = AudioGlobal.current_car
	car_npc_state = AudioGlobal.current_car_npc
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_car != AudioGlobal.current_car:
		print(current_car)
		print( AudioGlobal.current_car)
		current_car = AudioGlobal.current_car
		update_music()
		
	if current_car == 'car1' and AudioGlobal.current_car_npc != AudioGlobal.wife:
		AudioGlobal.current_car_npc = AudioGlobal.wife
	if current_car == 'car2' and AudioGlobal.current_car_npc != AudioGlobal.daughter:
		AudioGlobal.current_car_npc = AudioGlobal.daughter
	if current_car == 'car3' and AudioGlobal.current_car_npc != AudioGlobal.son:
		AudioGlobal.current_car_npc = AudioGlobal.son
		
	if car_npc_state != AudioGlobal.current_car_npc:
		car_npc_state = AudioGlobal.current_car_npc
		update_music()
		
			
func update_music():
	var current_car_music: String = ""
	
	var pick_music: Dictionary = {
		"starter": {"revealed": "Ambience", "hidden": "Ambience"},
		"car1":    {"revealed": "WifeRevealed", "hidden": "WifeHidden"}, # Wife Car
		"car2":    {"revealed": "DaughterRevealed", "hidden": "DaughterHidden"}, # Daughter Car
		"car3":    {"revealed": "SonVoiced", "hidden": "SonInstrum"}, # Son Car
		"back_car":  {"revealed": "Ambience", "hidden": "Ambience"},
		"front_car": {"revealed": "Ambience", "hidden": "Ambience"}
	}
	
	print(current_car)
	# Safely fetch the music track or trigger an error if the car/state doesn't exist
	if pick_music.has(current_car) and pick_music[current_car].has(car_npc_state):
		current_car_music = pick_music[current_car][car_npc_state]
	bg_music_player.get_stream_playback().switch_to_clip_by_name(current_car_music)
		
