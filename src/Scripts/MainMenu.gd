extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_CreditsButton_pressed():
	$CanvasLayer/PlayButton.hide()
	$CanvasLayer/CreditsButton.hide()
	$CanvasLayer/ExitButton.hide()
	$CanvasLayer/BackButton.show()
	$CanvasLayer/CreditsLbl.show()

func _on_BackButton_pressed():
	$CanvasLayer/PlayButton.show()
	$CanvasLayer/CreditsButton.show()
	$CanvasLayer/ExitButton.show()
	$CanvasLayer/BackButton.hide()
	$CanvasLayer/CreditsLbl.hide()
