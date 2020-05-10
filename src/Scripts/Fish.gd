extends Area2D

export var SPEED = 150
export var CHASE_SPEED = 300
var screen_size
var swim_direct_horizontal
var chase_flag
var chase_food
var chase_direction
var fishName
var fishValue
var fishType
var swimType
var maxSize
var hungry

var foodDict = {"pink": 0, "yellow": 0, "green": 0, "blue": 0}
var pelletTypeDict = {0:'pink',1:"green",2:"yellow",3:"blue"}

var rng = RandomNumberGenerator.new()
var swim_location
var timer = Timer.new() # Create a new Timer node
var eatTimer = Timer.new()

var evolution_score

# Called when the node enters the scene tree for the first time.
func _ready():
	evolution_score = 0
	hungry = true
	fishValue = 10
	fishType = "BASE"
	swimType = "swim"
	rng.randomize ( )
	timer.set_wait_time(0.1)
	add_child(timer)# Add it to the node tree as the direct child
	timer.start()
	eatTimer.set_wait_time(2)
	add_child(eatTimer)# Add it to the node tree as the direct child
	eatTimer.start()
	if SPEED == null:
		SPEED = 150
	swim_direct_horizontal = 1
	screen_size = get_viewport_rect().size
	screen_size.x = 850
	find_swim_location()
	chase_flag = 0
	$AnimatedSprite.play("swim")
	$Name.text = getRandomName()


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
	if !hungry:
		yield(eatTimer, "timeout")
		hungry = true
	
	
	

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
	if chase_flag == 0 and area.name == 'Pellet' and hungry:
		chase_food = area
		chase_flag = 1
		hungry = false
		
		
func end_chase(food):
	foodDict[pelletTypeDict[food.get_owner().pelletType]] += 1
	chase_flag = 0
	$EatSFX.play(0)
	evolution_score += 1
	if evolution_score == 8:
		evolve()
	if evolution_score > 8:
		evolution_score = 0
		foodDict = {"pink": 0, "yellow": 0, "green": 0, "blue": 0}
		
		
func _on_eat_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if not(event.pressed and event.button_index == 1):	# Return if not left click
			return
		print("Clicked fish")
		GameManager.requestSellFish(self)

func getRandomName():
	if len(get_parent().fishNames) == 0:
		set_lines()
	var newName = get_parent().fishNames[randi() % get_parent().fishNames.size()]
	get_parent().fishNames.erase(newName)
	return newName
	
func set_lines():
	var file = File.new()
	file.open("res://fishNameList.txt", File.READ)
	var words = get_lines(file)
	file.close()
	get_parent().fishNames = words


static func get_lines(file):
	var lines = []
	while not file.eof_reached():
		lines.append(file.get_line())
	return lines

func find_swim_location():
	swim_location = Vector2(rng.randi_range(0,screen_size.x),rng.randi_range(0,screen_size.y))

func evolve():
	evolve_type_check()
	if !maxSize:
		print('evolve!')
		evolve_fx()
		$AnimatedSprite.play(swimType)
		evolution_score = 0
		foodDict = {"pink": 0, "yellow": 0, "green": 0, "blue": 0}

func evolve_fx():
	var growSFX = load("res://Audio/fishygrows.wav")
	$AudioStreamPlayer2D.stream = growSFX
	$AudioStreamPlayer2D.play(0)
	self.apply_scale(Vector2(1.5,1.5))

func evolve_type_check():
	if foodDict["green"] >= 5:
		if fishType == "BASE":
			fishType = "SHADOW"
			swimType = "swim_shad"
			fishValue = 120
		elif fishType == "SHADOW":
			fishType = "SKELETON"
			swimType = "swim_skel"
			fishValue = 250
	elif foodDict['yellow'] >= 5:
		if fishType == "BASE":
			fishType = "GOLD"
			swimType = "swim_gold"
			fishValue = 80
		elif fishType == "GOLD":
			fishType = "BIG_GOLD"
			swimType = "swim_gold"
			fishValue = 200
	elif foodDict.values().min() >= 2:
		if fishType == "BASE":
			fishType = "UNICORN"
			swimType = "swim_uni"
			fishValue = 150
		elif fishType == "UNICORN":
			fishType = "UBER"
			swimType = "swim_uber"
			fishValue = 300
		elif fishType == "DIAMOND":
			fishType = "RAINBOW"
			swimType = "swim_rain"
			fishValue = 800
	elif foodDict['blue'] >= 5:
		if fishType == "BIG_BASE":
			fishType = "DIAMOND"
			swimType = "swim_diam"
			fishValue = 500
	else:
		if fishType == "BASE":
			fishType = "MED_BASE"
			swimType = "swim"
			fishValue = 30
		elif fishType == "MED_BASE":
			fishType = "BIG_BASE"
			swimType = "swim"
			fishValue = 60
		else:
			maxSize = true
