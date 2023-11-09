extends Node
class_name StateMachine

signal transitioned(new_state_name:String)

#先设置一下常规的人物可能状态
#在State的enter()中只设置需要变成true的量，不设置需要变成false的量
#在exit()中只设置需要变成false的量，不设置需要变成true的量
#————————————
#处于地面，多指静止状态
var is_on_floor = true
#包括主动跳起和受击浮空
var is_in_air = false
#跳跃全过程，包括起跳和下落
var is_jumping = false
#特指跳跃的下落过程，包括从平台掉下
var is_falling = false
#战斗中，为否则是脱战
var is_in_battle = false
#主动攻击中，这里可以制作连招取消或被敌人破招等
var is_attacking = false
#受创硬直中，这里玩家受击失控，只能进行有限的操作，如草人，浮空调整等等
var is_taking_hurt = false
#倒地中
var is_down_to_ground = false
#死亡
var is_dead = false
#异常状态或被控制中
var is_in_abnormal_state = false

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
	#调用一下默认状态的enter工作，执行一些初始化。上面已经选定了默认是Idle
	if current_state:
		current_state.enter()
	pass # Replace with function body.


func _input(event):
	current_state.handle_input(event)
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
#	print("当前的状态是%s" %current_state)
#	print("新的状态是%s" %new_node)
	if new_node:
		current_state = new_node
		current_state.enter()
	pass
