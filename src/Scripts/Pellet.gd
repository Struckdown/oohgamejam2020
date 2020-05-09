extends Node2D

var FALL_SPEED = 1
enum pelletTypeOptions {PINK, YELLOW, GRAY}
var pelletType

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play(0)
	$Sprite.frame = randi() % 6
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move()
	

func move():
	self.position.y += FALL_SPEED


func setPelletType(type):
	pelletType = type
	#TODO update graphic
