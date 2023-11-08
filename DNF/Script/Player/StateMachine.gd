extends Node
class_name StateMachine

signal transitioned(new_state_name:String)

#下面这行得到的其实是Idle这个节点，因为返回绝对或相对路径，所以一定是String类型
@export var default_state = NodePath()

#可以把赋值操作强行拖到ready执行的时刻，此时必然场景中的全部节点已经准备好, 
#可以确保下面的get_node能取到有效值
@onready var current_state:State = get_node(default_state)


# Called when the node enters the scene tree for the first time.
func _ready():
	#记住，初始化并挂载是从上往下，但ready执行顺序是反过来。
	#这里先等一下角色初始化完成。
	#由于层级关系，这个owner一定是player本身，将其传递给所有的状态
	await owner.ready
	#transitioned.connect(Callable(self, "TransitionTo"))
	self.connect("transitioned", Callable(self, "TransitionTo"))
	var AnimatedSprite2D_Node = get_node("../Area2D_PlayerBody/AnimatedSprite2D_Body")
	
	#给所有子组件内的state_machine指定对象为我
	for child in get_children():
		if child is State:
			child.state_machine = self
			child.player = owner
			child.AnimatedSprite2D_Pawn = AnimatedSprite2D_Node
	#调用一下默认状态的enter工作，执行一些初始化
	if current_state:
		current_state.enter()
	pass # Replace with function body.


func _input(event):
#	current_state._input(event)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_state.update(delta)
	pass

func _physics_process(delta):
	current_state.physics_update(delta)
	pass

func TransitionTo(newState:String):
	#先检验有效性
	if not has_node(newState):
		return
	current_state.exit()
	#这里之前报错，因为后面获得的是节点，前面是State类的对象，类型不匹配
	#但是现在又不报错了
	var new_node = get_node(newState)
	if new_node:
		current_state = new_node
		current_state.enter()
	pass
