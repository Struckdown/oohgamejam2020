extends AnimatedSprite


var time = randi() % 1
var sinStr = ((randf()*0.3) + 0.5) * 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	position.y -= (delta * 100)
	position.x += (sin(time) * sinStr)


func _on_Timer_timeout():
	queue_free()
