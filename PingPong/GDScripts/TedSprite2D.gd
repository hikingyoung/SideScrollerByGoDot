extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed == true: 
				print(event.button_index)
				print("自定义的输入事件[模拟点击鼠标左键]被执行了")
				pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
