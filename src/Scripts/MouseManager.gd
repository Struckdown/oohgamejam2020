# Handles the logic of what the mouse does when clicking
extends Node

var mouseState = SELLING
enum {SELLING, FEED}

func _ready():
	mouseState = FEED

func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		if not(event.pressed and event.button_index == 1):	# Return if not left click
			return
		#IF VALID POSITION #TODO
		match mouseState:
			SELLING:
				pass
			FEED:
				if checkIfCanAffordPellet(1):
					spawnPellet(event.position)
			_:
				print("Invalid mouse state")

   #elif event is InputEventMouseMotion:
	#   print("Mouse Motion at: ", event.position)

   # Print the size of the viewport
   #print("Viewport Resolution is: ", get_viewport_rect().size)

func checkIfCanAffordPellet(cost):
	return cost <= GameManager.currency

func spawnPellet(location):
	GameManager.currency -= 1
	print("You now have " + str(GameManager.currency) + "money left")
	var scene = load("res://Scenes/Pellet.tscn")
	var pellet = scene.instance()
	get_parent().add_child(pellet)
	pellet.position = location
