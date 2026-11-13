extends Node2D

@export var dialogue_resource: DialogueResource = preload("res://dialogue/conversations/dialogue.dialogue")

#if the npc is a main character
@export var important = false
#
@export var imageOffset = Vector2(0,0)
#location of scribble
@export var scribbleOffset = Vector2(0, 0)

@export var NPCImageTexture = "res://art/temporary_art/shadow.png"
@export var NPCImageScale = Vector2(0.7, 0.7)

@onready var npc_image = $Sprite2D
@onready var interaction_area: Area2D = $Area2D
@onready var random_text: Label = $RandomSpeech
@onready var interaction_text: Label = $InteractText
@onready var scribble_image = $ScribbleImage


var game: Node2D

var player_in_range = false
var curSpeech = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)
	random_text.visible = false
	interaction_text.visible = false
	
	npc_image.position += imageOffset
	npc_image.scale = NPCImageScale
	
	if important:
		setup_important()
	else:
		setup_normal()

func setup_important() -> void:
	npc_image.texture = load(NPCImageTexture)
	scribble_image.position += scribbleOffset
	scribble_image.play("default")

func setup_normal() -> void:
	scribble_image.visible = false
	

func scribble_turn_off() -> void:
	for i in range(100):
		await get_tree().create_timer(0.05).timeout
		scribble_image.modulate.a -= 0.01

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and player_in_range:
		AudioGlobal.interaction = true
		AudioGlobal.play_sfx()
		interact()
		AudioGlobal.interaction = false

func interact() -> void:
	if get_game().player_talking:
		return
	
	if game.has_method("call_dialogue"):
		game.call_dialogue(dialogue_resource)
	

func get_game() -> Node2D:
	if game == null:
		game = get_tree().current_scene
	return game

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		interaction_text.visible = true

		print("entered")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		random_text.visible = false
		if important:
			interaction_text.visible = false
		#print("exited")
