extends Node2D

func _ready():
	$AnimationPlayer.play('Size')

var force = 0


func target_hit(target):
	var use_target = target
	if target.has_method('get_main_target'):
		use_target = target.get_main_target()
	print('burst')
	print(target)
	if use_target.has_method('expell'):
		use_target.expell(force)

func _on_Area2D_area_entered(area):
	target_hit(area)

func _on_Area2D_body_entered(body):
	target_hit(body)
