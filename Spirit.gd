extends KinematicBody

var possession_strength = 2
var exposed_strength = 1
var exposed = true

var mission_type = null
var mission_target = null

var velocity = Vector2()

export (Color) var state_cover = Color(255,255,255)
export (Color) var state_hesitate = Color(255,255,255)
export (Color) var state_flee = Color(255,255,255)
export (Color) var state_attack = Color(255,255,255)
export (Color) var state_else = Color(255,255,255)

func set_debug_colours():
	if elapsed < hesitation:
		pass#modulate = state_hesitate
	elif mission_type == 'cover':
		pass#modulate = state_cover
	elif mission_type == 'flee':
		pass#modulate = state_flee
	elif mission_type == 'attack':
		pass#modulate = state_attack
	else:
		pass#modulate = state_else

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func expell(damage):
	var target = possession_strength
	if exposed:
		target = exposed_strength
	if not exposed:
		if damage >= possession_strength:
			#TODO
			return true
	else:
		if damage >= exposed_strength:
			kill()

func kill():
	queue_free()

func possess_object(object):
	var success = object.possess(self)
	if success:
		exposed = false

const speed = 2000
const accel = 30
func get_velocity(delta):
	var direction = translation.direction_to(mission_target.position)
	var diff = direction * accel
	var new = velocity + diff
	if new.length() > speed:
		new = new.normalized()*speed
	return new * delta

func end_mission():
	mission_target = null
	mission_type = null

func choose_mission():
	pass
	#var covers = get_tree().get_nodes_in_group('possessable')
	#end_mission()
	#if covers.size() > 0:
	#	var target_distance = null
	#	var new_target = null
	#	for cover in covers:
	#		if cover.is_possessed:
	#			continue
	#		var one_distance = translation.distance_to(cover.position)
	#		if target_distance == null or one_distance < target_distance:
	#			target_distance = one_distance
	#			new_target = cover
	#	if new_target != null:
	#		mission_target = new_target
	#		mission_type = 'cover'

func is_mission_valid():
	if mission_type == 'cover':
		if mission_target != null and not mission_target.is_possessed():
			return true
		return false

var hesitation = 10.0
var elapsed = 10.0
func hesitate(time=10):
	hesitation = time
	elapsed = 0

func _physics_process(delta):
	set_debug_colours()
	if elapsed < hesitation:
		elapsed += delta
		return
	if exposed:
		# look for cover
		if mission_type == null:
			choose_mission()
		if mission_type == null:
			hesitate()
	if mission_target != null:
		velocity = get_velocity(delta)
		var asd = move_and_collide(velocity)
		if asd != null:
			if asd.collider.get_parent() == mission_target:
				var success = mission_target.possess(self)
				if success:
					exposed = false
					end_mission()
				else:
					choose_mission()
		
		# attack
		#flee
