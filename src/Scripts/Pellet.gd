extends Node2D

var FALL_SPEED = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move()
	

func move():
	self.position.y += FALL_SPEED
