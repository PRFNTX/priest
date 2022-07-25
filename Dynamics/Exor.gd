extends Node2D

var force = 0

func _ready():
	$AnimationPlayer.play('effect')

func target_hit(target):
	print(force)
	var use_target = target
	if target.has_method('get_main_target'):
		use_target = target.get_main_target()
	print('exor')

	if use_target.has_method('expell'):
		use_target.expell(force)

func _on_Area2D_area_entered(area):
	target_hit(area)

func _on_Area2D_body_entered(body):
	target_hit(body)
