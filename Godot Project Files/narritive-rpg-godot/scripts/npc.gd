extends Node2D

@export var speech = [
	"Hello there",
	"frick you",
	"Imma a projection"
	]


#if the npc is a main character
@export var important = false

@onready var interaction_area: Area2D = $Area2D
@onready var random_text: Label = $RandomSpeech
@onready var interaction_text: Label = $InteractText






var player_in_range = false
var curSpeech = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)
	random_text.visible = false
	interaction_text.visible = false
	if important:
		setup_important()
	else:
		setup_normal()

func setup_important() -> void:
	$Sprite2D.texture = load("res://art/temporary_art/shadow.png")
	

func setup_normal() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and player_in_range and important:
		interact()

func interact() -> void:
	print("Interacted with important npc")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		curSpeech = randi() % speech.size()
		random_text.text = speech[curSpeech]
		random_text.visible = true
		if important:
			interaction_text.visible = true
		#print("entered")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		random_text.visible = false
		if important:
			interaction_text.visible = false
		#print("exited")
