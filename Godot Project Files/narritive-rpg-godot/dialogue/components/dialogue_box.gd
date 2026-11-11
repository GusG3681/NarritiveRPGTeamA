class_name DialogueBox extends MarginContainer


signal finished_typing()

# Color palette:
# Color("392c31")
# Color("4a3c4a")
# Color("5a555a")
# Color("62696a")
# Color("73817b")
# Color("83898b")
# Color("83918b")
# Color("a49da4")
# Color("c5b2bd")
# Color("d5becd")
# Color("ded6de")
# Color("e6eaee")

const CHARACTERS = {
	pc = {
	#	portrait = preload("res://portraits/nathan.svg"),
		name = "FATHER",
		side = "left",
		color = Color("83898b")
	},
	unknown = {
	#	portrait = preload("res://portraits/coco.svg"),
		name = "UNKNOWN",
		side = "right",
		color = Color("5a555a"),
	},
	ia = {
	#	portrait = preload("res://portraits/nathan.svg"),
		name = "INTERCOM",
		side = "right",
		color = Color("ded6de")
	},
	w = {
	#	portrait = preload("res://portraits/nathan.svg"),
		name = "WIFE",
		side = "right",
		color = Color("73817b")
	},
	npc1 = {
	#	portrait = preload("res://portraits/nathan.svg"),
		name = "PASSENGER",
		side = "right",
		color = Color("392c31")
	},
	npc2 = {
	#	portrait = preload("res://portraits/nathan.svg"),
		name = "PASSENGER",
		side = "right",
		color = Color("392c31")
	},
	npcs = {
	#	portrait = preload("res://portraits/nathan.svg"),
		name = "PASSENGER",
		side = "right",
		color = Color("5a555a")
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

var ticket_tex = preload("res://art/ui_art/new_ticket.png")

@onready var dialogue: HBoxContainer = %Dialogue
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
		character_name.text = "???" #dialogue_line.character

		var character: Dictionary = CHARACTERS[dialogue_line.character.to_lower()]
		character_name.text = character.name
		if character.side == "left":
			offset_transform_rotation = 0.05
			#left_character.texture = character.portrait
		else:
			offset_transform_rotation = -0.05
			#right_character.texture = character.portrait
		ticket.modulate = character.color
	dialogue_label.dialogue_line = dialogue_line

	if not dialogue_line.character.is_empty():
		dialogue_label.type_out()


#region Signals


func _on_dialogue_label_finished_typing() -> void:
	if is_inside_tree():
		finished_typing.emit()


#endregion
