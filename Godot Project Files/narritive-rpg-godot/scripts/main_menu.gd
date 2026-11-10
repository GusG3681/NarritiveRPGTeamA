extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options_menu: Panel = $OptionsMenu

# Called when the node enters the scene tree for the first time.
# Makes all Main Buttons visible only.
func _ready() -> void:
	main_buttons.visible = true
	options_menu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	print("Start pressed")
	# Put transition here (optional)
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_options_pressed() -> void:
	print("Options pressed")
	main_buttons.visible = false
	options_menu.visible = true


func _on_quit_pressed() -> void:
	print("Quit pressed")
	# Placeholder quit method:
	get_tree().quit()


func _on_back_pressed() -> void:
	_ready()
