class_name DialogueBox extends MarginContainer


signal finished_typing()


const CHARACTERS = {
	nathan = {
	#	portrait = preload("res://portraits/nathan.svg"),
		side = "left",
		color = Color(1, 0.869, 0.776)
	},
	coco = {
	#	portrait = preload("res://portraits/coco.svg"),
		side = "right",
		color = Color(0.755, 0.908, 1)
	},
		intercom_angel = {
	#	portrait = preload("res://portraits/nathan.svg"),
		side = "right",
		color = Color(0.870, 0.839, 0.870)
	},
		bad_father = {
	#	portrait = preload("res://portraits/nathan.svg"),
		side = "left",
		color = Color(0.513, 0.537, 0.545)
	}
}


var dialogue_line: DialogueLine:
	set(value):
		dialogue_line = value
		update_dialogue()
	get:
		return dialogue_line

var is_typing:
	get:
		return dialogue_label.is_typing

var ticket_tex = preload("res://art/ui_art/subway_ticket.png")

@onready var dialogue: HBoxContainer = %Dialogue
@onready var background: ColorRect = %Background
@onready var character_name: Label = %CharacterName
@onready var dialogue_label: DialogueLabel = %DialogueLabel
@onready var left_character: TextureRect = %LeftCharacter
@onready var right_character: TextureRect = %RightCharacter
@onready var action_label: Label = %ActionLabel
@onready var ticket: TextureRect = %Ticket



## Finish typing instantly
func skip_typing() -> void:
	dialogue_label.skip_typing()


func update_dialogue() -> void:
	ticket.texture = ticket_tex
	#left_character.texture = null
	#right_character.texture = null
	
	if dialogue_line.character.is_empty():
		dialogue.hide()
		action_label.show()
		action_label.text = dialogue_line.text
	else:
		dialogue.show()
		action_label.hide()
		character_name.text = dialogue_line.character

		var character: Dictionary = CHARACTERS[dialogue_line.character.to_lower()]
		if character.side == "left":
			offset_transform_rotation = 0.05
			#left_character.texture = character.portrait
		else:
			offset_transform_rotation = -0.05
			#right_character.texture = character.portrait
		background.color = character.color
		ticket.modulate = character.color
	dialogue_label.dialogue_line = dialogue_line

	if not dialogue_line.character.is_empty():
		dialogue_label.type_out()


#region Signals


func _on_dialogue_label_finished_typing() -> void:
	if is_inside_tree():
		finished_typing.emit()


#endregion
