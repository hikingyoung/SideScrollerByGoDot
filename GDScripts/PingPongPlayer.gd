extends Area2D
@export var NewX =5
@export var bPlayer1 = true
@export var speed = 1
# Called when the node enters the scene tree for the first time.

func _ready():
	self.connect("TedDefineSignal", Callable(self, "SelfDefineFuncForSignal"))
	emit_signal("TedDefineSignal", "我被触发了！")
	pass # Replace with function body.

signal TedDefineSignal

func SelfDefineFuncForSignal(b):
	print(b)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  bPlayer1 :
		self.position.y += (Input.get_action_strength("MoveDown")  - Input.get_action_strength("MoveUp"))*speed
	else :
		self.position.y += (Input.get_action_strength("SpeedDown") - Input.get_action_strength("SpeedUp"))*speed 
	
	pass





func _on_area_entered(area):
	if area.is_in_group("Ball"):
		area.vec.x = NewX
		#get_node("AudioStreamPlayer2D").play()
		$AudioStreamPlayer2D.play()
	pass # Replace with function body.
