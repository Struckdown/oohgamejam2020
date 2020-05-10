extends Area2D


var autofeederLevel = [0,0,0,0]
var maxDelay = 5
var delay = maxDelay

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.autofeeder = self

# Takes in int [0,3]
func levelUp(num):
	autofeederLevel[num] = autofeederLevel[num] + 1
	delay = float(maxDelay) / float(autofeederLevel[num])
	updateSpawnTimer(num, delay)

func updateSpawnTimer(type, newDelay):
	var timer = getTimer(type)
	if newDelay > 0:
		timer.wait_time = newDelay
		timer.start()
	else:
		timer.stop()

func spawnPellet(type, location):
	var scene = load("res://Scenes/Pellet.tscn")
	var pellet = scene.instance()
	get_parent().add_child(pellet)
	match type:
		0:
			pellet.setPelletType("pink")
		1:
			pellet.setPelletType("yellow")
		2:
			pellet.setPelletType("green")
		3:
			pellet.setPelletType("blue")
	pellet.global_position = location

func _on_Timer_timeout(type):
	var x = $CollisionShape2D.shape.extents.x * 2
	var y = $CollisionShape2D.shape.extents.y * 2
	var pelletX = randi() % int(x)
	var pelletY = randi() % int(y)
	spawnPellet(type, Vector2(pelletX, pelletY))


func getTimer(timerNum):
	var timer
	match timerNum:
		0:
			timer = $TimerPink
		1:
			timer = $TimerYellow
		2:
			timer = $TimerGreen
		3:
			timer = $TimerBlue
	return timer

# Takes in int from 0-3 representing timer index, and true or false for nowPaused
func pauseTimer(timerInt, nowPaused):
	var timer = getTimer(timerInt)
	timer.paused = nowPaused
