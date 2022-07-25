extends "res://Script.gd"

var target_shown = true
var target_res = preload("res://Assets/Circle.png")
var effect_res = preload("res://Dynamics/Exor.tscn")
var target = null


# TODO add max range
func _ready():
	target = Sprite.new()
	target.scale = Vector2(0.05, 0.05)
	target.texture = target_res
	add_child(target)
	target.hide()

func stop_and_reset():
	target.hide()
	.stop_and_reset()

func show_icon():
	target.show()

func _physics_process(delta):
	._physics_process(delta)
	if self.progress >= self.complete_at:
		show_icon()
	target.position = get_local_mouse_position()

func complete():
	var effect = effect_res.instance()
	add_child(effect)
	effect.force = force
	effect.position = get_local_mouse_position()
	.complete()
