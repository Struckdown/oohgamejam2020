extends Node2D


var passiveCosts = [50, 250, 500, "???"]
var passiveIncomeDelay = [-1, 3, 1, 0.2]

var passiveBulkCosts = [100, 400, 750, "???"]
var passiveIncomeAmounts = [1, 2, 3, 5]

var incomeMultiplierCosts = [150, 350, 1000, "???"]
var incomeMultipliers = [1, 1.5, 2.5, 4]

# Key values
var passiveIncomeLevel = 0
var passiveIncomeAmountLevel = 0
var incomeMultiplierLevel = 0
var incomeMultiplier = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.decorationManager = self
	$Fern.hide()
	$Starfish.hide()
	$LongPlant.hide()


func levelup(type):
	match type:
		"delay":
			if passiveIncomeLevel < 3:
				$Fern.show()
				$Fern.frame = passiveIncomeLevel
				passiveIncomeLevel += 1
		"bulk":
			if passiveIncomeAmountLevel < 3:
				$Starfish.show()
				$Starfish.frame = passiveIncomeAmountLevel
				passiveIncomeAmountLevel += 1
		"multiplier":
			if incomeMultiplierLevel < 3:
				incomeMultiplier = incomeMultipliers[incomeMultiplierLevel]
				$LongPlant.show()
				$LongPlant.frame = incomeMultiplierLevel
				incomeMultiplierLevel += 1
		_:
			"Invalid type, try passive, bulk, multiplier or incomeDelay"
	if passiveIncomeLevel > 0:
		$Timer.wait_time = passiveIncomeDelay[passiveIncomeLevel]
		$Timer.start()

func getDecorCost(type):
	match type:
		"delay":
			return passiveCosts[passiveIncomeLevel]
		"bulk":
			return passiveBulkCosts[passiveIncomeAmountLevel]
		"multiplier":
			return incomeMultiplierCosts[incomeMultiplierLevel]

func _on_Timer_timeout():
	GameManager.currency += passiveIncomeAmounts[passiveIncomeAmountLevel]
	GameManager.updateUI()
