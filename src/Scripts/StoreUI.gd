extends Control

export(NodePath) var mouseManagerRef


# Called when the node enters the scene tree for the first time.
func _ready():
	updateUI()
	mouseManagerRef = get_node(mouseManagerRef)
	get_parent().get_node("MouseManager")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func updateUI():
	$Panel/Currency.text = "Money: " + str(GameManager.currency)


func _on_FeedButton_pressed():
	mouseManagerRef.setMouseState("feed")


func _on_SellButton_pressed():
	mouseManagerRef.setMouseState("sell")


func _on_BuyFish_pressed():
	GameManager.spawnFish()
