extends Control

export(NodePath) var mouseManagerRef
var autofeedCost = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	updateUI()
	mouseManagerRef = get_node(mouseManagerRef)
	GameManager.storeUI = self
	get_parent().get_node("MouseManager")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func updateUI():
	$Panel/Currency.text = str(GameManager.currency)
	if GameManager.autofeeder != null:
		autofeedCost = GameManager.autofeeder.autofeederLevel * 10
		$Panel/AutofeederBtn/AutoFeederLbl.text = "Autofeed " + str(GameManager.autofeeder.autofeederLevel)
		$Panel/AutofeederBtn/AutoFeederCostLbl2.text = "$" + str(autofeedCost)

func _on_FeedButton_pressed():
	mouseManagerRef.setMouseState("feed")
	$AudioStreamPlayer.play()


func _on_SellButton_pressed():
	mouseManagerRef.setMouseState("sell")
	$AudioStreamPlayer.play()


func _on_BuyFish_pressed():
	GameManager.spawnFish()
	$AudioStreamPlayer.play()


func _on_AutofeederBtn_pressed():
	if GameManager.currency > autofeedCost:
		GameManager.autofeeder.levelUp()
		GameManager.currency -= autofeedCost
		updateUI()

