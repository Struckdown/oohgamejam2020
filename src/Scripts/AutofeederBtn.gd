tool
extends Control

export(int) var initialCost setget setInitialCost
var currentCost = initialCost
export(int) var feederType

# Called when the node enters the scene tree for the first time.
func _ready():
	var img = load("res://Art/HUD Elements/buy autofeeder (" + str(feederType) + ").png")
	$AutofeederBtn.texture_normal = img


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setInitialCost(val):
	$AutoFeederCostLbl2.text = "$"+str(val)
	currentCost = val
	
