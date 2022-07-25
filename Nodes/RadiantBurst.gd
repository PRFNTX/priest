extends "res://Script.gd"

const zone = preload("res://Dynamics/Burst.tscn")


func complete():
	var new_zone = zone.instance()
	add_child(new_zone)
	new_zone.force = force
	.complete()
