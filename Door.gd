extends "res://SceneTransition.gd"

export (bool) var open = false
export (bool) var locked = false

func open():
	if not locked:
		open = true
	#animation and stuff

func close():
	open = false

func lock():
	locked = true

func unlock():
	locked = false

func _ready():
	pass # Replace with function body.

func show_action_text():
	$ActionText.visible = true

func hide_action_text():
	$ActionText.visible = false

func _on_Area2D_body_entered(body):
	if body.get('is_player'):
		body.add_action(connection_id, funcref(self, 'entered'))
		show_action_text()

func _on_Area2D_body_exited(body):
	if body.is_player:
		body.remove_action(connection_id)
		hide_action_text()
