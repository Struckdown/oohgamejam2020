# Handles the logic of what the mouse does when clicking
extends Node

enum mouseStates {SELLING, FEED}
var mouseState = mouseStates.SELLING
var activePelletType = "pink"


func _ready():
	mouseState = mouseStates.FEED
	GameManager.mouseManager = self

func _unhandled_input(event):
	# Mouse in viewport coordinates
	
	if event is InputEventMouseButton:
		if not(event.pressed and event.button_index == 1):	# Return if not left click
			return
		match mouseState:
			mouseStates.SELLING:
				pass	# Handled by fish being clicked
			mouseStates.FEED:
				if checkIfCanAffordPellet(getPelletCost(activePelletType)):
					spawnPellet(event.position)
			_:
				print("Invalid mouse state")
		GameManager.updateUI()

   #elif event is InputEventMouseMotion:
	#   print("Mouse Motion at: ", event.position)

   # Print the size of the viewport
   #print("Viewport Resolution is: ", get_viewport_rect().size)


func requestSell(fish):
	if mouseState == mouseStates.SELLING:
		GameManager.sellFish(fish)
		var soldSFX = load("res://Audio/fishsold.wav")
		$AudioStreamPlayer.stream = soldSFX
		$AudioStreamPlayer.play()
		

func checkIfCanAffordPellet(cost):
	return cost <= GameManager.currency

func spawnPellet(location):
	if GameManager.currency >= getPelletCost(activePelletType):
		GameManager.currency -= getPelletCost(activePelletType)
		var scene = load("res://Scenes/Pellet.tscn")
		var pellet = scene.instance()
		get_parent().add_child(pellet)
		pellet.position = location
		pellet.setPelletType(activePelletType)

func getPelletCost(pelletType):
	match pelletType:
		"pink":
			return 0
		"yellow":
			return 1
		"green":
			return 3
		"blue":
			return 10

func setMouseState(state):
	match state:
		"sell":
			mouseState = mouseStates.SELLING
		"feed":
			mouseState = mouseStates.FEED
		_:
			print("Illegal mouse state")
