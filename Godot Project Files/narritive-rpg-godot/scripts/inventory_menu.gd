extends CanvasLayer

@export var placeholder_texture: Texture2D = preload("res://art/temporary_art/Polarid-Photo-Print.jpg") # placeholder image, random stock photo
@export var slot_count: int = 12
@export var slot_size: Vector2 = Vector2(64, 64)

# 2 columns and 6 rows
@onready var panel: PanelContainer = $PanelContainer
@onready var slot_box: GridContainer = $PanelContainer/GridContainer

var slot_icons: Array[TextureRect] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel.position = Vector2(20, 20)
	slot_box.columns = 2
	
	# Building the Slots
	for i in Inventory.max_items:
		var slot : PanelContainer = PanelContainer.new()
		slot.custom_minimum_size = slot_size
		
		var icon : TextureRect = TextureRect.new()
		icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		
		slot.add_child(icon)
		slot_box.add_child(slot)
		slot_icons.append(icon)
		
	Inventory.inventory_changed.connect(refresh)
	refresh()
	panel.visible = false
	
func refresh() -> void:
	for i in slot_icons.size():
		if i < Inventory.inventory.size():
			var item: Dictionary = Inventory.inventory[i]
			var icon = item.get("icon")
			slot_icons[i].texture = icon if icon != null else placeholder_texture
		else:
			slot_icons[i].texture = null;

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Inventory Toggle"):
		panel.visible = not panel.visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
