extends Node2D

export (PackedScene) var target
export (int) var connection_id = 0

var target_room
export (NodePath) var room = null

# CAN use target instead of twin for non-bonary doors later
var twin = null setget set_twin
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func entered(entity):
	target_room.entered(entity, connection_id)
	get_tree().set_current_scene(target_room)

func from_door(entity):
	get_tree().current_scene.add_child(entity)
	entity.global_position = $EntryPosition.global_position
	var in_room = null
	if room == null:
		in_room = get_parent()
	else:
		in_room = get_node(room)
	in_room.enter_complete()

func activate():
	#binary doors only, TODO
	var active_doors = get_tree().get_nodes_in_group('unpaired_scene_transitions')
	for door in active_doors:
		if door.connection_id == connection_id:
			connect_door(door)
			return
	if twin == null:
		add_to_group('unpaired_scene_transitions')

func connect_door(door):
	twin = door
	door.twin = self

func set_twin(in_twin):
	if (twin != null):
		print("ERROR DOUBLE TWINNED DOORS")
	remove_from_group('unpaired_scene_transitions')
	twin = in_twin

func init():
	target_room = target.instance()
	get_tree().get_root().add_child(target_room)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
