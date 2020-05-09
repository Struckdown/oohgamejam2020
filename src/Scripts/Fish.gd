extends Area2D

export var SPEED = 200
export var CHASE_SPEED = 400
var screen_size
var swim_direct_horizontal
var chase_flag
var chase_food

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	swim_direct_horizontal = 1
	screen_size = get_viewport_rect().size
	chase_flag = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chase_flag == 0:
		swim_passive(delta)
	else:
		var chase_direction = (Area2D.get_pos() - chase_food.get_pos()).normalized()
		position += chase_direction * delta * CHASE_SPEED
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
		
	
	
	

func swim_passive(delta):
	var velocity = Vector2()  # The player's movement vector.
	velocity.x += swim_direct_horizontal
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	if position.x == 0 or position.x == screen_size.x:
		swim_direct_horizontal = swim_direct_horizontal * -1
		


func _on_Fish_area_entered(area):
	if chase_flag == 0 and area.name == "Food":
		chase_food = area
