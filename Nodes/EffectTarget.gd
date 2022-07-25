extends StaticBody2D

export (NodePath) var target_node

func get_main_target():
	return get_node(target_node)
