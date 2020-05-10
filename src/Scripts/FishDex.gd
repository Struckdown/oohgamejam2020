extends Control


var currentPage = 0
var maxPages = 5
var pages = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = $Master/Content.get_children()
	for child in children:
		pages.append(child)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
	pages[currentPage].show()


func _on_ForwardButton_pressed():
	changePage(currentPage+1)


func _on_BackwardsButton_pressed():
	changePage(currentPage-1)
