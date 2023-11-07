extends Node
class_name StateMachine

signal transitioned(new_state_name:String)
@export var default_state = NodePath()
#可以把赋值操作强行拖到ready执行的时刻，此时必然场景中的全部节点已经准备好, 
#可以确保下面的get_node能取到有效值
@onready var current_state :State = get_node(default_state)

# Called when the node enters the scene tree for the first time.
func _ready():
	#记住，初始化并挂载是从上往下，但ready执行顺序是反过来。
	#这里先等一下角色初始化完成。
	#由于层级关系，这个owner一定是player本身，将其传递给所有的状态
	await owner.ready
	#transitioned.connect(Callable(self, "TransitionTo"))
	self.connect("transitioned", Callable(self, "TransitionTo"))
	#给所有子组件内的state_machine指定对象为我
	for child in get_children():
		if child is State:
			child.state_machine = self
			child.player = owner
	#调用一下默认状态的enter工作，执行一些初始化
	print("当前默认的状态是 %s"%default_state)
	current_state.enter()
	pass # Replace with function body.


func _physics_process(delta):
	var directionX = Input.get_axis("ui_left", "ui_right")
	if directionX:
		# transitioned.emit("run")
		emit_signal("transitioned", "run")
		pass
	pass

func _input(event):
	current_state._input(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_state._process(delta)
	pass
 
func TransitionTo(newState :String):
	if not has_node(newState):
		return
	current_state.exit()
	current_state = get_node(newState)
	current_state.enter()
	pass
