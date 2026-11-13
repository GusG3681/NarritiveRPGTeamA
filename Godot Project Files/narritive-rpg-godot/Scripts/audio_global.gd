extends Node

var current_car: String 
# current_car can be front_car, car_starter, car1, car2, car3, backcar 
var music_vol: int
var sfx_vol: int

var interaction: bool
var dialogue: bool
# dialogue or interaction
@export var interaction_player: AudioStreamPlayer 
@export var dialogue_player: AudioStreamPlayer 

var current_car_npc: String
# this is the state of the current car's npc, so the 
# string would be "revealed" or "hidden"
var wife: String
var daughter: String
var son: String


func play_sfx() -> void:
	interaction_player = $/root/Game/WorldAudioManager/interactionSFX
	dialogue_player =$/root/Game/WorldAudioManager/dialogueSFX
	
	dialogue_player.volume_db = -5

	if dialogue:
		dialogue_player.play()
	if interaction:
		interaction_player.play()
		
	if interaction_player.playing and dialogue_player.playing:
		dialogue_player.volume_db = -10	

	
