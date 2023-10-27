extends Area2D
@export var NewX =5
@export var bPlayer1 = true
@export var speed = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in get_overlapping_areas():
		if i.is_in_group("Ball"):
			i.vec.x = NewX

	
	if  bPlayer1 :
		self.position.y += (Input.get_action_strength("MoveDown")  - Input.get_action_strength("MoveUp"))*speed
	else :
		self.position.y += (Input.get_action_strength("SpeedDown") - Input.get_action_strength("SpeedUp"))*speed 
	
	pass
