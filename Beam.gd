extends Area2D

const duration: float = 2.0
var remaining: float = 2.0

var force = 0

func _ready():
	set_physics_process(true)

# add on colision at some point
func _physics_process(delta):
	remaining -= delta
	modulate.a = pow(remaining/duration, 2)
	if remaining < 0:
		self.queue_free()

func target_hit(target):
	var use_target = target
	if target.has_method('get_main_target'):
		use_target = target.get_main_target()
	print('burst')
	print(target)
	if use_target.has_method('expell'):
		use_target.expell(force)

func _on_Beam_area_entered(area):
	target_hit(area)

func _on_Beam_body_entered(body):
	target_hit(body)
