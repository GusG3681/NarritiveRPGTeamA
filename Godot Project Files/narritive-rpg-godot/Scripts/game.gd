extends Node2D

#random variables for testing purposes only
var countdown = 500
var countReset = 2000

# contains a list of the labels in the intercoms
var intercomList = []

#list of onready calls for objects

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#prepares a tree of the intercom grouped obejcts in order to call intercom_speak later on
	var l = get_tree().get_nodes_in_group("intercom")
	for item in l:
		intercomList.append(item.get_node("Label"))
	
	#will connect events custom signal handlers
	Events.good_ending.connect(_on_good_ending)
	Events.bad_ending.connect(_on_bad_ending)
	Events.settings_request.connect(_on_settings_request)
	Events.exit_request.connect(_on_exit_request)
	
	

#rando stuff
var INTERCOMTAUNTS1 = ["You suck", "do better", "I am the intercom Angel"]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if countdown > 0:
		countdown -=1
	else:
		intercom_speak(INTERCOMTAUNTS1[randi() % INTERCOMTAUNTS1.size()])
		countdown = countReset

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



#signal handlers
func _on_bad_ending() -> void:
	print("just got the bad ending")

func _on_good_ending() -> void:
	print("Just got the GOOD ENDING!!!")

func _on_settings_request() -> void:
	print("settings menu requested")

func _on_exit_request() -> void:
	print("exit to menu requested")
