extends Node2D

var FALL_SPEED = 1
enum pelletTypeOptions {PINK, GREEN, YELLOW, BLUE}
var pelletType = pelletTypeOptions.PINK

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play(0)
	setPelletType("pink")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move()
	

func move():
	self.position.y += FALL_SPEED


func setPelletType(type):
	match type:
		"pink":
			pelletType = pelletTypeOptions.PINK
		"green":
			pelletType = pelletTypeOptions.GREEN
		"yellow":
			pelletType = pelletTypeOptions.YELLOW
		"blue":
			pelletType = pelletTypeOptions.BLUE
	$Sprite.frame = pelletType + len(pelletTypeOptions) * (randi() % 6)
