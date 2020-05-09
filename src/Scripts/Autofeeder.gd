extends Area2D


var autofeederLevel = 0
var maxDelay = 5
var delay = maxDelay

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.autofeeder = self

func levelUp():
	autofeederLevel += 1
	delay = maxDelay / autofeederLevel
	updateSpawnTimer(delay)

func updateSpawnTimer(newDelay):
	if newDelay != -1:
		$Timer.wait_time = newDelay
		$Timer.start()
	else:
		$Timer.stop()

func spawnPellet(location):
	GameManager.currency -= 1
	var scene = load("res://Scenes/Pellet.tscn")
	var pellet = scene.instance()
	get_parent().add_child(pellet)
	pellet.global_position = location

func _on_Timer_timeout():
	var x = $CollisionShape2D.shape.extents.x * 2
	var y = $CollisionShape2D.shape.extents.y * 2
	var pelletX = randi() % int(x)
	var pelletY = randi() % int(y)
	spawnPellet(Vector2(pelletX, pelletY))
