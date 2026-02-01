extends TextureButton

var number

signal tile_pressed
signal slide_completed

# Update the number of the tile
func set_text(new_number):
	number = new_number
	$Number/Label.text = str(number)

# Update the background image of the tile
func set_sprite(new_frame, size, tile_size):
	var sprite = $Sprite
	if sprite == null:
		push_error("Sprite node not found in tile scene!")
		return

	update_size(size, tile_size)

	sprite.set_hframes(size)
	sprite.set_vframes(size)
	sprite.set_frame(new_frame)

# scale to the new tile_size
func update_size(size, tile_size):
	var new_size = Vector2(tile_size, tile_size)
	set_size(new_size)
	$Number.set_size(new_size)
	$Number/ColorRect.set_size(new_size)
	$Number/Label.set_size(new_size)
	$Panel.set_size(new_size)

	if $Sprite != null and $Sprite.texture != null:
		var to_scale = size * (new_size / $Sprite.texture.get_size())
		$Sprite.set_scale(to_scale)

# Update the entire background image
func set_sprite_texture(texture):
	if $Sprite != null:
		$Sprite.set_texture(texture)
	else:
		push_error("Sprite node not found in tile scene!")

# Slide the tile to a new position
func slide_to(new_position, duration):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rect_position", new_position, duration)
	await tween.finished
	emit_signal("slide_completed", number)

# Hide / Show the number of the tile
func set_number_visible(state):
	$Number.visible = state

# Tile is pressed
func _on_Tile_pressed():
	emit_signal("tile_pressed", number)


func _on_pressed() -> void:
	pass # Replace with function body.
