extends Control


var currentPage = 0
var maxPages = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func toggleVis():
	if visible:
		hide()
	else:
		show()

func changePage(newPage):
	if newPage > 0 and newPage < maxPages:	
		currentPage = newPage


func _on_ForwardButton_toggled(_button_pressed):
	changePage(currentPage+1)


func _on_BackwardsButton_toggled(_button_pressed):
	changePage(currentPage-1)
