extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var scene = load("res://Scenes/Bubble.tscn")
	var bubble = scene.instance()
	self.add_child(bubble)
	var x = $Area2D/CollisionShape2D.shape.extents.x * 2
	var y = $Area2D/CollisionShape2D.shape.extents.y * 2
	var bubbleX = (randi() % int(x)) - int(x/2)
	var bubbleY = randi() % int(y)
	bubble.position = Vector2(bubbleX, bubbleY)
	$Timer.wait_time = (randi() % 2) + 2	# [2...4] second spawn time
