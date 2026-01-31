extends CharacterBody2D

@export var move_speed := 200.0
@export var turn_speed := 3.0
@export var fly_speed := 150.0
@export var max_height := 200.0

var height := 0.0

@onready var animated_sprite := $AnimatedSprite2D

func _physics_process(delta):
	# TURN (A / D)
	var turn_input := Input.get_axis("move_left", "move_right")
	rotation += turn_input * turn_speed * delta

	# FORWARD MOVEMENT (W)
	var forward := Input.get_action_strength("move_forward")
	var direction := Vector2.UP.rotated(rotation)
	velocity = direction * forward * move_speed

	# FLY UP / DOWN (Space / Shift)
	if Input.is_action_pressed("fly_up"):
		height += fly_speed * delta
	if Input.is_action_pressed("fly_down"):
		height -= fly_speed * delta

	height = clamp(height, 0.0, max_height)

	# VISUAL FLY EFFECT
	animated_sprite.position.y = -height
	animated_sprite.scale = Vector2.ONE * (1.0 + height / 600.0)

	# ANIMATIONS
	if height > 10:
		animated_sprite.play("fly")
	elif forward > 0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")

	move_and_slide()
