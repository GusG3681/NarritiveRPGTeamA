extends Control

@export var dialogue_resource: DialogueResource

@onready var scroll: ScrollContainer = %Scroll
@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var content: VBoxContainer = %Content
@onready var dialogue_box: DialogueBox = %DialogueBox
@onready var answer_overlay: ColorRect = %AnswerOverlay
@onready var answer_edit: LineEdit = %AnswerEdit
@onready var submit_button: Button = %SubmitButton
@onready var responses_overlay: ColorRect = %ResponsesOverlay
@onready var responses_menu: DialogueResponsesMenu = %ResponsesMenu
@onready var black_screen = %BlackScreen
@onready var animation_player = $AnimationPlayer


var favourite_food: String = ""
var correct_answer: int = 0
var guess: int = 0
var tries: int = 0
var guess_is_number: bool = false

#if it's true calls a fade out at the end of the conversation
var should_fade_out: bool = false
var should_fade_out_long: bool = false

var dialogue_has_ended: bool = false

signal dialogue_finished
signal on_transition_finished

#region Hooks


func _ready() -> void:
	
	dialogue_box.visible = false
	dialogue_box.grab_focus()

	answer_overlay.hide()
	responses_overlay.hide()

	scroll.get_v_scroll_bar().share(v_scroll_bar)

	# fading color rect only appears when it's needed
	black_screen.visible = false
	# connects siganls to animation player
	animation_player.animation_finished.connect(_on_animation_finished)
	
#endregion

func start_dialogue(blackscreen: bool = false, skip_fade: bool = false, fade_long: bool = false) -> void:
	if blackscreen:
		if skip_fade:
			instant_black()
		else:
			fade_in()
		await on_transition_finished
		if fade_long:
			should_fade_out_long = true
		else:
			should_fade_out = true
	dialogue_box.visible = true
	dialogue_box.dialogue_line = await dialogue_resource.get_next_dialogue_line("start")
	show_text()
	
#region Mutations


func ask_for_string() -> String:
	answer_edit.text = ""
	answer_overlay.show()
	answer_edit.grab_focus()
	await submit_button.pressed
	answer_overlay.hide()
	return answer_edit.text


func ask_for_number() -> int:
	answer_edit.text = ""
	answer_overlay.show()
	answer_edit.grab_focus()
	await submit_button.pressed
	answer_overlay.hide()
	guess_is_number = str(answer_edit.text.to_int()) == answer_edit.text
	tries += 1
	return answer_edit.text.to_int()

#endregion

#region Helpers


func next_line(next_id: String) -> void:
	var next_dialogue_line: DialogueLine = await dialogue_resource.get_next_dialogue_line(next_id)
	if not is_instance_valid(next_dialogue_line): 
		if dialogue_has_ended == false:
			dialogue_has_ended = true
			if should_fade_out_long:
				fade_out_long()
				await on_transition_finished
			if should_fade_out:
				fade_out()
				await on_transition_finished
			if not should_fade_out_long: 
				hide_text()
				await on_transition_finished
			dialogue_finished.emit()
		return

	if next_dialogue_line.type == DMConstants.TYPE_RESPONSE:
		responses_overlay.show()
		responses_menu.responses = next_dialogue_line.responses
		responses_menu.get_menu_items()[0].grab_focus()
	else:
		var copy: DialogueBox = dialogue_box.duplicate()
		content.add_child(copy)
		content.move_child(copy, dialogue_box.get_index())
		dialogue_box.dialogue_line = next_dialogue_line

		await get_tree().create_timer(0.2).timeout
		scroll.set_deferred("scroll_vertical", 10000)

		dialogue_box.grab_focus()


func handle_click(event: InputEvent) -> void:
	var is_left_click: bool = event.is_pressed() and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT
	var is_accept_key: bool = event.is_action_pressed("ui_accept")
	if is_left_click or is_accept_key:
		
		get_viewport().set_input_as_handled()
		if dialogue_box.is_typing:
			dialogue_box.skip_typing()
		else:
			next_line(dialogue_box.dialogue_line.next_id)

func fade_in() -> void:
	black_screen.visible = true
	animation_player.play("fade_to_black")

func fade_out() -> void:
	black_screen.visible = true
	animation_player.play("fade_to_normal")

func fade_out_long() -> void:
	black_screen.visible = true
	animation_player.play("fade_to_normal_long")

func instant_black() -> void:
	black_screen.visible = true
	animation_player.play("set_to_black")
	
func show_text() -> void:
	animation_player.play("show_text")
	
func hide_text() -> void:
	animation_player.play("hide_text")


#endregion

#region Signals

func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		on_transition_finished.emit()
	if anim_name == "fade_to_normal":
		black_screen.visible = false
		on_transition_finished.emit()
	if anim_name == "set_to_black":
		on_transition_finished.emit()
	if anim_name == "fade_to_normal_long":
		on_transition_finished.emit()
	if anim_name == "hide_text":
		on_transition_finished.emit()
	pass

func _on_gui_input(event: InputEvent) -> void:
	handle_click(event)


func _on_dialogue_box_gui_input(event: InputEvent) -> void:
	handle_click(event)


func _on_responses_menu_response_selected(response: Variant) -> void:
	responses_overlay.hide()
	next_line(response.next_id)


func _on_answer_edit_gui_input(event: InputEvent) -> void:
	if event.is_pressed() and event is InputEventKey and (event as InputEventKey).keycode == KEY_ENTER:
		submit_button.pressed.emit()


#endregion
