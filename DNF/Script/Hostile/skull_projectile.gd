extends Node2D

var fly:bool = false
var initial_position 
# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if fly:
		self.position.x -= 5
		pass
	pass

func _on_area_2d_area_entered(area):
	var node =  get_node("Area2D")
	node.hide()
	node.set_collision_mask_value(9, false)
	fly =  true
	await get_tree().create_timer(5).timeout
	fly = false
	self.position = initial_position
	node.set_collision_mask_value(9, true)
	node.show()
	pass # Replace with function body.
