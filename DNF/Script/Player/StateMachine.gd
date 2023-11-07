extends Node
class_name StateMachine

signal transitioned(new_state_name)
@export var default_state = NodePath()
@onready var state :State = get_node(default_state)

# Called when the node enters the scene tree for the first time.
func _ready():
	#记住，初始化并挂载是从上往下，但ready执行顺序是反过来。
	#这里先等一下角色初始化完成
	await owner.ready
	#给所有子组件内的state_machine指定对象为我
	for child in get_children():
		if child is State:
			child.state_machine = self
	
	#调用一下默认状态的enter工作，执行一些初始化
	state.enter()
	
	
	print(default_state)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
