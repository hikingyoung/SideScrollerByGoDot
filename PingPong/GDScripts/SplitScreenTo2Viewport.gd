extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	$SubViewportContainer_Right/SubViewport.world_2d = $SubViewportContainer_Left/SubViewport.world_2d
	var CustomEvent = InputEventMouseButton.new()
	CustomEvent.pressed = true
	CustomEvent.button_index = MOUSE_BUTTON_LEFT
	$SubViewportContainer_Left/SubViewport.push_input(CustomEvent)
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed == true: 
				print(event.button_index)
				print("鼠标左键被点击了")
				$SubViewportContainer_Right/SubViewport.set_input_as_handled()
				pass
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed == true: 
				print(event.button_index)
				print("鼠标左键又被点击了")
				pass	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
