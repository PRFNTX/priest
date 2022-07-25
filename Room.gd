extends Spatial

export (Array, NodePath) var scene_transitions = []
# Called when the node enters the scene tree for the first time.
func _ready():
	# rooms can do things when an adjacent room is entered, but generally doors cannot be used
	pass

func entered(entity, transition_id):
	var entered_door = null
	for door in scene_transitions:
		door.activate()
		if door.connection_id == transition_id:
			entered_door = door
	if entered_door != null:
		entered_door.from_door(entity)

func enter_complete(entity, transition_id):
	pass
