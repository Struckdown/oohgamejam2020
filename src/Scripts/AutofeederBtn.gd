extends Control

export(int) var initialCost
var currentCost = initialCost
export(int) var feederType
var level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var img = load("res://Art/HUD Elements/buy autofeeder (" + str(feederType) + ").png")
	$AutofeederBtn.texture_normal = img
	$AutoFeederCostLbl2.text = "$"+str(initialCost)
	currentCost = initialCost
	

func _on_AutofeederBtn_pressed():
	if GameManager.currency >= currentCost:
		GameManager.currency -= currentCost
		level += 1
		GameManager.upgradeAutofeeder(feederType)
		incrementCost()
		if level == 1:
			$CheckBox.pressed = true
			$CheckBox.disabled = false
		GameManager.updateUI()

func incrementCost():
	print(currentCost)
	currentCost = floor(initialCost * pow(1.5, level))
	$AutoFeederCostLbl2.text = "$"+str(currentCost)


func _on_CheckBox_toggled(button_pressed):
	GameManager.autofeederPause(feederType, !button_pressed)
