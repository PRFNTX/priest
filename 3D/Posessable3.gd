extends GameObject3
class_name Possessable3

export (Color) var state_possessed = Color(255,255,255)
export (Color) var state_normal = Color(255,255,255)

func set_debug_colors():
	if sprite == null:
		return
	if is_possessed:
		$Sprite.modulate = state_possessed
	elif blessed:
		$Sprite.modulate = state_blessed
	else:
		$Sprite.modulate = state_normal

var is_possessed = false
var possessor = null

func _ready():
	pass

func expell(force = 0):
	print(is_possessed)
	if is_possessed:
		print(possessor)
		var success = possessor.expell(force)
		print(success)
		if success:
			is_possessed = false
			possessor = null
	set_debug_colors()

func possess(spirit):
	var success = false
	if not is_possessed:
		is_possessed = true
		possessor = spirit
		add_child(spirit)
		spirit.hide()
		success = true
	set_debug_colors()
	return success
