# Handles the logic of what the mouse does when clicking
extends Node

enum mouseStates {SELLING, FEED}
var mouseState = mouseStates.SELLING

func _ready():
	mouseState = mouseStates.FEED

func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		if not(event.pressed and event.button_index == 1):	# Return if not left click
			return
		#IF VALID POSITION #TODO
		match mouseState:
			mouseStates.SELLING:
				var fish = getOverlappingFish(event.position)
				if fish != null:
					GameManager.sell(fish)
			mouseStates.FEED:
				if checkIfCanAffordPellet(1):
					spawnPellet(event.position)
			_:
				print("Invalid mouse state")
		updateUI()

   #elif event is InputEventMouseMotion:
	#   print("Mouse Motion at: ", event.position)

   # Print the size of the viewport
   #print("Viewport Resolution is: ", get_viewport_rect().size)


func requestSell(fish):
	if mouseState == mouseStates.SELLING:
		GameManager.sellFish(fish)
		

func getOverlappingFish(location):
	var overlappedFish = []
	for fish in GameManager.fishArray:
		pass #if fish.eat_area.eat_box

func checkIfCanAffordPellet(cost):
	return cost <= GameManager.currency

func spawnPellet(location):
	GameManager.currency -= 1
	var scene = load("res://Scenes/Pellet.tscn")
	var pellet = scene.instance()
	get_parent().add_child(pellet)
	pellet.position = location


func updateUI():
	get_parent().find_node("StoreUI").updateUI()
	
func setMouseState(state):
	match state:
		"sell":
			mouseState = mouseStates.SELLING
		"feed":
			mouseState = mouseStates.FEED
		_:
			print("Illegal mouse state")
