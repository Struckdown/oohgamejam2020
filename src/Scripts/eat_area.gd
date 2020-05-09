extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_eat_area_area_entered(area):
	if area.name == 'Pellet':
		get_owner().end_chase(area)
		print('Yum')
		area.get_owner().queue_free()
