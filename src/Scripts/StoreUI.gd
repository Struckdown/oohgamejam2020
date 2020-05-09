extends Control

export(NodePath) var mouseManagerRef
var autofeedCost = 10
onready var autofeedLbl = $Content/MainShopUI/VBoxContainer/AutofeederBtn/AutoFeederLbl
onready var autofeedCostLbl = $Content/MainShopUI/VBoxContainer/AutofeederBtn/AutoFeederCostLbl2

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
	$Background/Currency.text = str(GameManager.currency)
	if GameManager.autofeeder != null:
		autofeedCost = GameManager.autofeeder.autofeederLevel * 10
		if $Content/MainShopUI.visible:
			autofeedLbl.text = "Autofeed " + str(GameManager.autofeeder.autofeederLevel)
			autofeedCostLbl.text = "$" + str(autofeedCost)

func _on_FeedButton_pressed():
	mouseManagerRef.setMouseState("feed")
	$AudioStreamPlayer.play()


func _on_SellButton_pressed():
	mouseManagerRef.setMouseState("sell")
	$AudioStreamPlayer.play()


func _on_BuyFish_pressed():
	var bought = GameManager.spawnFish()
	if bought:
		$BuyFishSFX.play(0)


func _on_AutofeederBtn_pressed():
	if GameManager.currency > autofeedCost:
		GameManager.autofeeder.levelUp()
		GameManager.currency -= autofeedCost
		updateUI()



func _on_Main_pressed():
	$Content/MainShopUI.show()
	$Content/PelletShopUI.hide()
	updateUI()


func _on_Pellets_pressed():
	$Content/MainShopUI.hide()
	$Content/PelletShopUI.show()
	updateUI()

func _on_Plants_pressed():
	$Content/MainShopUI.hide()
	$Content/PelletShopUI.hide()
	updateUI()


func _on_Pellet_pressed(type):
	mouseManagerRef.activePelletType = type
	mouseManagerRef.setMouseState("feed")
