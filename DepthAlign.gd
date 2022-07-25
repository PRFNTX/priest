extends Spatial
tool
class_name DepthAlign

export(int) var depth = 1 setget set_depth

func set_depth(val):
	depth = val
	translation.z = depth

func _ready():
	pass
