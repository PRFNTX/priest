extends Spatial
tool
# TODO possessable

export(bool) var lit = true setget light_candle
var lighting = false
var lit_amount = 1
var light_rate = 0.4

func light_candle(val):
	if (val):
		lighting = true
	else:
		lit_amount = 0
		lit = false
		lighting = false

# Called when the node enters the scene tree for the first time.
var light = null
var spot = null
var base_range = 0
var base_energy = 1
var base_spot_energy = 0.1
func _ready():
	light = $Light
	spot = $SpotLight
	base_range = light.omni_range
	base_energy = light.light_energy
	base_spot_energy = spot.light_energy


## Light flicker
export(float, 3.5, 4, 0.1) var flicker_factor = 3.81
export(float, 0, 5, 0.01) var base_scale = 1 setget set_scale

func set_scale(new_scale):
	if light != null:
		light.omni_range = new_scale
	base_scale = new_scale
	
var flicker_scale = 1.2
export(float, 0.1, 1, 0.02) var flicker_rate = 0.6
onready var base_flicker_rate = flicker_rate
var scale_factor = 1.1
export(float) var n2 = 0.8


func get_next_flicker():
	return flicker_factor*n2*(1-(n2))

var count = 0
func do_flicker(delta):
	count += delta
	if count > flicker_rate:
		count = 0
		n2 = get_next_flicker()
	scale_factor = lerp(scale_factor, n2, delta/flicker_rate)
	affect_light(scale_factor)
	#light.light_energy = base_scale*(0.8 + scale_factor/(5))

func affect_light(factor):
	light.light_energy = lit_amount*base_energy*(0.8 + factor/5)
	light.omni_range = lit_amount*base_range*(0.8 + factor/4)
	spot.light_energy = lit_amount*base_spot_energy*(0.8 + factor/3)

func get_next_flicker_rate():
	return 3.81*flicker_rate_rate*(1-(flicker_rate_rate))

var flicker_rate_rate = flicker_rate

var flicker_count = 0
func do_flicker_rate(delta):
	flicker_count += delta
	if flicker_count > flicker_rate_rate:
		flicker_count = 0
		flicker_rate_rate = get_next_flicker_rate()
		flicker_rate = sqrt(base_flicker_rate * flicker_rate_rate)


func _process(delta):
	if light != null:
		do_flicker(delta)
		do_flicker_rate(delta)
		cast_to_camera()
	if lighting:
		do_light(delta)

func do_light(delta):
	if lit_amount <= 1:
		lit_amount += delta/light_rate
		lit_amount = min(1, lit_amount)
		if lit_amount == 1:
			lit = true
			lighting = false

onready var ray = $LightPoint/RayCast
func cast_to_camera():
	var camera = get_viewport().get_camera()
	if camera == null:
		return
	ray.cast_to = camera.global_transform.origin - ray.global_transform.origin
	if ray.is_colliding():
		print('hide')
		$SpotLight.hide()
	else:
		print('show')
		$SpotLight.show()
