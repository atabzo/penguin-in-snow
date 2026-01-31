extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.body_entered.connect(_on_entered_npc1)


func _on_entered_npc1(body):
	if body is CharacterBody2D:
		var dialogue_resource = load("res://dialogues/npc_1_1.dialogue")
		DialogueManager.show_dialogue_balloon(dialogue_resource, "start")
		
