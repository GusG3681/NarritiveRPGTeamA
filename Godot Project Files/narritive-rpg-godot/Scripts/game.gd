extends Node2D


#random variables for testing purposes only
var countdown = 500
var countReset = 2000

# contains a list of the labels in the intercoms
var intercomList = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var l = get_tree().get_nodes_in_group("intercom")
	for item in l:
		intercomList.append(item.get_node("Label"))
	


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


var INTERCOMTAUNTS1 = ["You suck", "do better", "I am the intercom Angel"]
