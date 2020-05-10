extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_CreditsButton_pressed():
	$Control/PlayButton.hide()
	$Control/CreditsButton.hide()
	$Control/ExitButton.hide()
	$Control/BackButton.show()
	$Control/CreditsLbl.show()

func _on_BackButton_pressed():
	$Control/PlayButton.show()
	$Control/CreditsButton.show()
	$Control/ExitButton.show()
	$Control/BackButton.hide()
	$Control/CreditsLbl.hide()
