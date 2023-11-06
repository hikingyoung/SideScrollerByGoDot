extends Area2D
var vec:Vector2 = Vector2(5,5)
#const InitPosition:Vector2 = Vector2(50,50)
var InitPosition:Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	InitPosition = self.position
	self.add_to_group("Ball")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position += vec
	#if position.x > 1152 or position.y >648: 
	#	self.reset()
	

func reset():
	if position.x > 100:
		TedSingle.P1_Score += 1
	else:
		TedSingle.P2_Score += 1			
	position = InitPosition
