# Handles the logic of what the mouse does when clicking
extends Node

var currency = 10
var fishArray = []	# TODO replace with Fish scene as manager?
var rng = RandomNumberGenerator.new()
var MAX_SCREEN_WIDTH = 600
var mouseManager = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var current_scene = null
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	for child in current_scene.get_children():
		if child.name == "Fish":
			fishArray.append(child) 
	var world = get_tree().get_root().find_node("World", true, false)
	mouseManager = world.find_node("MouseManager")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawnFish():
	var scene = load("res://Scenes/Fish.tscn")
	var fish = scene.instance()
	var root = get_tree().get_root()
	var current_scene = root.get_child(root.get_child_count() - 1)
	current_scene.add_child(fish)
	rng.randomize()
	var xpos = rng.randf_range(0, MAX_SCREEN_WIDTH)
	var ypos = rng.randf_range(-50, 50)
	print(xpos, str(ypos))
	fish.position = Vector2(xpos, ypos)
	fishArray.append(fish)


func sellFish(fish):
	currency += 10 # TODO replace with fish worth
	fish.queue_free()
