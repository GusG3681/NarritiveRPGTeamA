extends Control

func _ready():
	hide()
	$PauseAnimationPlayer.play("RESET")

func resume() -> void:
	print("Resumed")
	get_tree().paused = false
	$PauseAnimationPlayer.play_backwards("blur")
	
func pause() -> void:
	print("Paused")
	show()
	get_tree().paused = true
	$PauseAnimationPlayer.play("blur")

func testEsc() -> void:
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		pause()	
	elif Input.is_action_just_pressed("escape") and get_tree().paused:
		resume()

func _on_resume_btn_pressed() -> void:
	resume()

func _on_to_menu_btn_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_quit_btn_game_pressed() -> void:
	print("Quit pressed")
	# Placeholder quit method:
	get_tree().quit()

func _process(delta):
	testEsc()
