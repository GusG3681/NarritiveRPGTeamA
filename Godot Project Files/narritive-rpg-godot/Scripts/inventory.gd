extends Node2D

# Array to hold the items picked up in the inventory
var inventory: Array[Dictionary] = [];

func add_item(item_data: Dictionary) -> void:
		inventory.append(item_data)
		print("Picked up an item: ", item_data.name)
		print("Current inventory: ", inventory.map(func(item): return item.name))
		
func pop_item(item_name: String) -> Dictionary:
		for i in range(inventory.size()):
			if inventory[i].get("name") == item_name:
				var removed_item = inventory.pop_at(i)
				print("Removed item: ", item_name)
				print("Current inventory: ", inventory.map(func(item): return item.name))
				return removed_item
		return {}
		
func has_item(item_name: String) -> bool:
		for item in inventory:
			if item.get("name") == item_name:
				return true
		return false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
