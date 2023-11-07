extends State


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func enter():
	#自有变量name，值为当前节点名，即Idle
	#注意写法，中间没有空格
	print("进入了状态%s"%name)

func exit():
	print("离开当前状态%s"%name)
