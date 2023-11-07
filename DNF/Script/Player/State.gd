class_name  State
extends Node
#一个指针变量，可以是任意类型；在赋值后会确定唯一类型
var state_machine = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	pass
	
func _physics_process(delta):
	pass

#进入此状态时要初始化或提前准备的工作
func enter():
	pass
	
#离开当前状态时要执行的工作，多是销毁、回收、复位等
func exit():
	pass
	
#处于当前状态时将一直执行的动作	
func Loop():
	pass
