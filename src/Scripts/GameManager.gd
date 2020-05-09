# Handles the logic of what the mouse does when clicking
extends Node

var currency = 10
var fishArray = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var current_scene = null
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	for child in current_scene.get_children():
		if child.name == "Fish":
			fishArray.append(child) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
