extends Node2D

#random variables for testing purposes only
var countdown = 500
var countReset = 2000

# contains a list of the labels in the intercoms
var intercomList = []

# variable to create a canvas layer in the scene if there isn't one already (this is for dialogue ui to be anchored to)
var ui_layer: CanvasLayer

#list of onready calls for objects

# variables needed for handling dialogue
var dialogue_scene = preload("res://dialogue/components/conversation.tscn")
var player_talking = false 
var dialogue_layer: CanvasLayer
var dialogue: Control
var player
var is_pregame_dialogue = false

# sets up all of the dialogue that is called via the game root and not by NPCs
var autorun_dialogue = {
	pregame = {
		script = preload("res://dialogue/conversations/pregame.dialogue")
	},
	introduction = {
		script = preload("res://dialogue/conversations/introduction.dialogue")
	},
	enter_wife_car = {
		script = preload("res://dialogue/conversations/enter_wife_car.dialogue")
	},
	locked_door = {
		script = preload("res://dialogue/conversations/locked_door.dialogue")
	}
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#prepares a tree of the intercom grouped obejcts in order to call intercom_speak later on
	var l = get_tree().get_nodes_in_group("intercom")
	for item in l:
		intercomList.append(item.get_node("Label"))
		
	#creates canvad layer if one doesn't already exist
	if get_tree().get_first_node_in_group("dialogue_layer") == null:
		ui_layer = CanvasLayer.new()
		ui_layer.add_to_group("dialogue_layer")
		add_child(ui_layer)
	dialogue_layer = get_tree().get_first_node_in_group("dialogue_layer")

	#will connect events custom signal handlers
	Events.good_ending.connect(_on_good_ending)
	Events.bad_ending.connect(_on_bad_ending)
	Events.settings_request.connect(_on_settings_request)
	Events.exit_request.connect(_on_exit_request)
	Events.finished_wife_car.connect(_on_finished_wife_car_recieved)
	
	is_pregame_dialogue = true
	call_dialogue(autorun_dialogue.pregame.script, true, true, true)
	
	AudioGlobal.current_car_npc = 'hidden'
	if AudioGlobal.wife == '':
		AudioGlobal.wife = 'hidden'
	if AudioGlobal.son == '':
		AudioGlobal.son = 'hidden'
	if AudioGlobal.daughter == '':
		AudioGlobal.daughter = 'hidden'

#rando stuff
var INTERCOMTAUNTS1 = ["You suck", "do better", "I am the intercom Angel"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func intercom_speak(speech) -> void:
	var current = ""
	for i in speech:
		current += i
		if i == " ":
			continue
		
		# this needs to change to the text update
		for item in intercomList:
			item.text = current
		#print(current)
		await get_tree().create_timer(0.06).timeout
	await get_tree().create_timer(4).timeout
	for item in intercomList:
		item.text = ""

func call_dialogue(dialogue_resource, blackscreen: bool = false, skip_fade: bool = false, fade_long: bool = false) -> void:
	player_talking = true
	player = get_tree().get_first_node_in_group("player")
	player.can_move = false
	dialogue = dialogue_scene.instantiate()
	dialogue.dialogue_resource = dialogue_resource
	dialogue.dialogue_finished.connect(_on_dialogue_finished)
	dialogue_layer.add_child(dialogue)
	dialogue.start_dialogue(blackscreen, skip_fade, fade_long)

#signal handlers
func _on_bad_ending() -> void:
	print("just got the bad ending")

func _on_good_ending() -> void:
	print("Just got the GOOD ENDING!!!")

func _on_settings_request() -> void:
	print("settings menu requested")

func _on_exit_request() -> void:
	print("exit to menu requested")
	
func _on_dialogue_finished() -> void:
	if is_pregame_dialogue == true:
		is_pregame_dialogue = false
		dialogue.queue_free()
		await get_tree().process_frame
		await get_tree().create_timer(2).timeout
		call_dialogue(autorun_dialogue.introduction.script)
	else:
		dialogue.queue_free()
		await get_tree().process_frame
		player = get_tree().get_first_node_in_group("player")
		player.can_move = true
		await get_tree().create_timer(2).timeout
		player_talking = false
	


func _on_finished_wife_car_recieved() -> void:
	$Wife.scribble_turn_off()
	AudioGlobal.wife = 'revealed'
	AudioGlobal.current_car_npc = 'revealed'
	CarDoor.door_locks['car_door2'] = true
	#print('unlock:' + str(CarDoor.door_locks['car_door2']))
	
