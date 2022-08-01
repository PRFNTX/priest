extends KinematicBody
const is_player = true
var items = [
	null,
	null,
	null,
	null,
]

var current_item = 0

var item_in_cursor = false 
	
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	pass
	#var scripts_count = $Node2D.get_child_count()
	#scripts = $Node2D.get_children()
	#for i in range(0, scripts_count):
	#	scripts[i].init(i)
	#get_parent().entered(self, 0)
	
var moving_left = false
var moving_right = false
var moving_down = false
var velocity = Vector3(0,0,0)
const movement_speed = 1.2
const crouch_modifier = 0.6
const default_snap = Vector3(0, 32, 0)
const gravity = -20

func _physics_process(delta):
	set_velocity(delta)
	velocity = move_and_slide_with_snap(velocity, Vector3(0, 32, 0),Vector3.UP)

func set_velocity(delta):
	var current_movement_speed = movement_speed
	if moving_down:
		current_movement_speed = current_movement_speed * crouch_modifier
	if moving_left and not moving_right:
		velocity.x = -1 * current_movement_speed
	elif moving_right and not moving_left:
		velocity.x = current_movement_speed
	else:
		velocity.x = 0
	if not is_on_floor():
		velocity.y += gravity * delta


func _input(event):
	if event.is_action_pressed('move_left'):
		print('move_left')
		moving_left = true
	elif event.is_action_released('move_left'):
		print('no move_left')
		moving_left = false
	if event.is_action_pressed('move_right'):
		print('move_right')
		moving_right = true
	elif event.is_action_released('move_right'):
		print('no move_right')
		moving_right = false
	if event.is_action_pressed('move_down'):
		print('move_down')
		moving_down = true
	elif event.is_action_released('move_down'):
		print('no move_down')
		moving_down = false
	elif event.is_action('move_up'): #enter room
		pass
	elif event.is_action('item_current'): # use current item
		pass
	elif event.is_action_pressed('item_previous'): # make previous item the current one
		print('pressed item next')
		current_item = (current_item + 1) % 4
	elif event.is_action_pressed('item_next'): # make next item the current one
		print('pressed item previous')
		current_item = (current_item + 3) % 4 # 3 = -3 mod 4
	elif event.is_action_pressed('action'):
		print('action')
		#var all_actions = actions.values()
		#if all_actions.size() > 0:
			#all_actions[0].call_func(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
