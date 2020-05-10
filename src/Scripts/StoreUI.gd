extends Control

export(NodePath) var mouseManagerRef
export(NodePath) var decorationManagerRef
export(NodePath) var fishDexRef
var autofeedCost = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	mouseManagerRef = get_node(mouseManagerRef)
	decorationManagerRef = get_node(decorationManagerRef)
	fishDexRef = get_node(fishDexRef)
	GameManager.storeUI = self
	updateUI()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func updateUI():
	$Background/Currency.text = str(GameManager.currency)
	$Content/DecorationShopUI/VBoxContainer/DelayDecor/Cost.text = "$"+str(decorationManagerRef.getDecorCost("delay"))
	$Content/DecorationShopUI/VBoxContainer/BulkDecor/Cost.text = "$"+str(decorationManagerRef.getDecorCost("bulk"))
	$Content/DecorationShopUI/VBoxContainer/MultiplierDecor/Cost.text = "$"+str(decorationManagerRef.getDecorCost("multiplier"))
	$Content/MainShopUI/VBoxContainer/BuyFish/BuyFishCostLbl.text = "$"+str(getFishCost())

func getFishCost():
	return 10 + 3*len(GameManager.fishArray)

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
	if GameManager.currency >= autofeedCost:
		GameManager.autofeeder.levelUp()
		GameManager.currency -= autofeedCost
		updateUI()



func _on_Main_pressed():
	$Content/MainShopUI.show()
	$Content/PelletShopUI.hide()
	$Content/DecorationShopUI.hide()
	$Content/AutofeederShopUI.hide()
	updateUI()


func _on_Pellets_pressed():
	$Content/MainShopUI.hide()
	$Content/PelletShopUI.show()
	$Content/DecorationShopUI.hide()
	$Content/AutofeederShopUI.hide()
	updateUI()

func _on_Plants_pressed():
	$Content/MainShopUI.hide()
	$Content/PelletShopUI.hide()
	$Content/DecorationShopUI.show()
	$Content/AutofeederShopUI.hide()
	updateUI()

func _on_Autofeeder_pressed():
	$Content/MainShopUI.hide()
	$Content/PelletShopUI.hide()
	$Content/DecorationShopUI.hide()
	$Content/AutofeederShopUI.show()
	updateUI()


func _on_Pellet_pressed(type):
	mouseManagerRef.activePelletType = type
	mouseManagerRef.setMouseState("feed")


# Type is one of delay, bulk, multiplier
func _on_Plant_pressed(type):
	if decorationManagerRef.getDecorCost(type) is int:
		if GameManager.currency >= decorationManagerRef.getDecorCost(type):
			GameManager.currency -= decorationManagerRef.getDecorCost(type)
			decorationManagerRef.levelup(type)
			updateUI()


# Win the game
func _on_Plant4_pressed():
	if GameManager.currency >= 10000:
		GameManager.currency -= 10000
		get_tree().change_scene("res://Scenes/winGameScreen.tscn")





func _on_FishDex_pressed():
	fishDexRef.toggleVis()
