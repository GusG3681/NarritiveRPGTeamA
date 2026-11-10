extends Node2D

@export var item_name: String = "Memorabilia"
@export var item_icon: Texture2D

@onready var interaction_area: Area2D = $Area2D
@onready var text: Label = $Label
var player_in_range = false


func _ready() -> void:
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)
	text.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and player_in_range:
		pick_up()
	

func pick_up() -> void:
	print("input detected for memory")
	
	var item_data = {
		"name": item_name,
		"icon": item_icon
	}
	
	if Inventory.add_item(item_data):
		queue_free() # can be added to make the item dissapear after being picked up

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		text.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		text.visible = false
