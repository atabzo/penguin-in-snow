extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label
const base_text = "[E] to "

var active_areas= []
var can_interact = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
