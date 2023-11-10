extends Area2D
@onready var Body:Area2D = get_node("../Area2D_PlayerBody")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(Body)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_label():
	
	pass


func _on_area_entered(area):
	print(area)
	
	pass # Replace with function body.
