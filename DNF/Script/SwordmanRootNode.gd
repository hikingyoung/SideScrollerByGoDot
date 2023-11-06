extends Node2D

var acceleration = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.get_action_strength("MoveRight"):
		self.position.x += acceleration
	if Input.get_action_strength("MoveLeft"):
		self.position.x -= acceleration
	if Input.get_action_strength("MoveUp"):
		self.position.y -= acceleration
	if Input.get_action_strength("MoveDown"):
		self.position.y += acceleration
	if Input.get_action_strength("SpeedUp"):
		acceleration +=1
	if Input.get_action_strength("SpeedDown"):
		acceleration -=1
	if Input.get_action_strength("Jump"):
		$AnimatedSprite2D.position.y -=1
