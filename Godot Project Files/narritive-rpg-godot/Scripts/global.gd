extends Node

# character names
var father_name: String = "Deadbeat Loser Husband"
var wife_name: String = "Wife"
var daughter_name: String = "Daughter"
var son_name: String = "Son"
var intercom_name: String = "Intercom"

# wife prgress checks
var has_wedding_ring: bool = false
var has_alcohol_bottle: bool = false
var wife_dialogue_progress: int = 0
var has_divorce_papers: bool = false
var wife_identity_revealed: bool = false

# daughter progress checks
var daughter_dialogue_progress: int = 0
var daughter_identity_revealed: bool = false

# son progress checks
var son_dialogue_progress: int = 0
var son_identity_revealed: bool = false 

# door unlocks
var daughter_car_locked: bool = true # Whether or not the player can open the door at the right end of the wife car and move on to the daughter car
var angel_car_locked: bool = true # Whether the player can unlcoked the door to the first car, where the intercom angel is

# searchs the tree for nodes with the name of the character provided (ie Wife) by the dialogue and calls the reveal_identity function on NPCs
func reveal_charcter(character: String) -> void:
	var game = get_tree().current_scene
	var char = game.find_child(character)
	

#func obtained_memorabilia(has_memorabilia: bool) -> void:
	
