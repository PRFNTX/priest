extends Node2D
class_name GameObject

export (Color) var state_blessed = Color(255,255,255)
var blessed = false

func set_debug_colors():
	if sprite == null:
		return
	if blessed:
		$Sprite.modulate = state_blessed


var sprite = null
func _ready():
	sprite = get_node("Sprite")
