extends Node2D

@export var item_name: String = "Memorabilia"
@export var item_icon: Texture2D

@export var dialogue_resource: DialogueResource = preload("res://dialogue/conversations/dialogue.dialogue")

@onready var interaction_area: Area2D = $Area2D
@onready var text: Label = $Label
var player_in_range = false

var game: Node2D

func _ready() -> void:
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)
	text.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and player_in_range:
		AudioGlobal.interaction = true
		pick_up()
	else:
		AudioGlobal.interaction = false
	

func pick_up() -> void:
	AudioGlobal.play_sfx()
	AudioGlobal.interaction = false
	if get_game().player_talking:
		return
	
	if game.has_method("call_dialogue"):
		game.call_dialogue(dialogue_resource)
	
	print("input detected for memory")
	
	var item_data = {
		"name": item_name,
		"icon": item_icon
	}
	
	if Inventory.add_item(item_data):
		queue_free() # can be added to make the item dissapear after being picked up

func get_game() -> Node2D:
	if game == null:
		game = get_tree().current_scene
	return game


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		text.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		text.visible = false
