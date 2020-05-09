extends Area2D

export var SPEED = 200
export var CHASE_SPEED = 600
var screen_size
var swim_direct_horizontal
var chase_flag
var chase_food
var chase_direction


# Called when the node enters the scene tree for the first time.
func _ready():
	if SPEED == null:
		SPEED = 200
	swim_direct_horizontal = 1
	screen_size = get_viewport_rect().size
	chase_flag = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chase_flag == 0:
		swim_passive(delta)
	else:
		chase_direction = (chase_food.position - position).normalized()
		position.x -= chase_direction.y * delta * CHASE_SPEED
		position.y += chase_direction.x * delta * CHASE_SPEED
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
	print(area.name)
	if chase_flag == 0 and area.name == 'Pellet':
		chase_food = area
		chase_flag = 1
		
