extends CharacterBody2D

# Movement variables
@export var walk_speed = 200.0
@export var fly_sp eed = 150.0
@export var gravity = 980.0
@export var jump_velocity = -400.0
@export var fly_lift = -300.0

var is_flying = false
var facing_right = true

func _ready():
	# Initialize sprite
	pass

func _physics_process(delta):
	# Get input
	var direction = Input.get_axis("ui_left", "ui_right")
	var fly_input = Input.is_action_pressed("ui_accept")  # Spacebar
	var vertical_input = Input.get_axis("ui_up", "ui_down")
	
	# Handle flying mode
	if fly_input:
		is_flying = true
		velocity.y = fly_lift * vertical_input if vertical_input != 0 else velocity.y * 0.9
		
		# Horizontal movement while flying
		if direction:
			velocity.x = direction * fly_speed
		else:
			velocity.x = move_toward(velocity.x, 0, fly_speed * delta * 5)
	else:
		is_flying = false
		
		# Apply gravity when not flying
		if not is_on_floor():
			velocity.y += gravity * delta
		
		# Ground movement
		if direction:
			velocity.x = direction * walk_speed
		else:
			velocity.x = move_toward(velocity.x, 0, walk_speed)
		
		# Jump
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = jump_velocity
	
	# Flip sprite based on direction
	if direction > 0:
		facing_right = true
		$Sprite2D.flip_h = false
	elif direction < 0:
		facing_right = false
		$Sprite2D.flip_h = true
	
	# Apply movement
	move_and_slide()
	
	# Update animation based on state
	_update_animation()

func _update_animation():
	if is_flying:
		$AnimationPlayer.play("fly")
	elif not is_on_floor():
		$AnimationPlayer.play("jump")
	elif velocity.x != 0:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
