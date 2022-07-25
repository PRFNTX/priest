extends "res://Script.gd"

const ray = preload("res://Dynamics/Beam.tscn")


func complete():
	
	var new_ray = ray.instance()
	add_child(new_ray)
	new_ray.force = force
	var mouse_position = get_global_mouse_position()
	var angle = global_position.angle_to_point(mouse_position)
	new_ray.rotation = angle - (PI / 2)
	.complete()
