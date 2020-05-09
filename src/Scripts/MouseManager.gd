# Handles the logic of what the mouse does when clicking
extends Node

var mouseState
enum {SELLING, FEED_BASIC, FEED_SPECIAL}



func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		#IF VALID POSITION #TODO
		spawnPellet(event.position)

   #elif event is InputEventMouseMotion:
	#   print("Mouse Motion at: ", event.position)

   # Print the size of the viewport
   #print("Viewport Resolution is: ", get_viewport_rect().size)


func spawnPellet(location):
	var scene = load("res://Scenes/Pellet.tscn")
	var pellet = scene.instance()
	get_parent().add_child(pellet)
	pellet.position = location
	print("Pellet spawned")
