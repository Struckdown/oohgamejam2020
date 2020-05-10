extends Control


var currentPage = 0
var maxPages = 5
var pages = []
var unlocked = []


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.fishDex = self
	var children = $Master/Node2D/Content.get_children()
	for child in children:
		pages.append(child)
		unlocked.append(false)
	unlocked[0] = true


func toggleVis():
	if visible:
		hide()
	else:
		show()

func changePage(newPage):
	if newPage >= 0 and newPage < len(pages):
		currentPage = newPage
	for p in pages:
		p.hide()
	if unlocked[currentPage]:
		pages[currentPage].show()
		$Master/Node2D/MysteryFish.hide()
	else:
		$Master/Node2D/MysteryFish.show()
	$Master/Node2D/PageNum.text = str(currentPage+1)


func _on_ForwardButton_pressed():
	changePage(currentPage+1)


func _on_BackwardsButton_pressed():
	changePage(currentPage-1)

func unlockPage(page):
	unlocked[page] = true
