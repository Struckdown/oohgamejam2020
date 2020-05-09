extends Area2D

export var SPEED = 150
export var CHASE_SPEED = 300
var screen_size
var swim_direct_horizontal
var chase_flag
var chase_food
var chase_direction
var fishName

var rng = RandomNumberGenerator.new()
var swim_location
var timer = Timer.new() # Create a new Timer node

var evolution_score

# Called when the node enters the scene tree for the first time.
func _ready():
	evolution_score = 0
	rng.randomize ( )
	timer.set_wait_time(0.1)
	add_child(timer)# Add it to the node tree as the direct child
	timer.start()
	if SPEED == null:
		SPEED = 150
	swim_direct_horizontal = 1
	screen_size = get_viewport_rect().size
	screen_size.x = 850
	find_swim_location()
	chase_flag = 0
	$AnimatedSprite.play("swim")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chase_flag == 0:
		swim_passive(delta)
	elif !weakref(chase_food).get_ref():
		chase_flag = 0
	else:
		chase_direction = (chase_food.global_position - position).normalized()
		$AnimatedSprite.flip_h = chase_direction.x > 0
		position += chase_direction * delta * CHASE_SPEED
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
		
	
	
	

func swim_passive(delta):
	var velocity = Vector2()  # The player's movement vector.
	velocity += (swim_location - position)
	if velocity.x < 2 and velocity.y < 2:
		yield(timer, "timeout")
		find_swim_location()
	elif velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		
		$AnimatedSprite.flip_h = velocity.x > 0
		position += velocity * delta
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
		
		


func _on_Fish_area_entered(area):
	if chase_flag == 0 and area.name == 'Pellet':
		chase_food = area
		chase_flag = 1
		
func end_chase():
	chase_flag = 0
	evolution_score += 1
	if evolution_score == 5:
		print('evolve!')
		$AnimatedSprite.play("swim_uni")
		self.apply_scale(Vector2(1.5,1.5))
		

func _on_eat_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if not(event.pressed and event.button_index == 1):	# Return if not left click
			return
		print("Clicked fish")
		GameManager.requestSellFish(self)

func getRandomName():
	var file = File.new()
	file.open("res://fishNameList.txt", File.READ)
	var words = get_lines(file)
	file.close()
	var newName = words[randi() % words.size()]
	return newName

static func get_lines(file):
	var lines = []
	while not file.eof_reached():
		lines.append(file.get_line())
	return lines

func find_swim_location():
	swim_location = Vector2(rng.randi_range(0,screen_size.x),rng.randi_range(0,screen_size.y))
