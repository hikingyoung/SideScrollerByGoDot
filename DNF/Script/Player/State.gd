class_name  State
extends Node

#一个指针变量，可以是任意类型；在赋值后会确定唯一类型
#传入状态管理者 StateMachine
var state_machine:StateMachine = null
#传入当前玩家，方便后续操作
var player:Player = null
var AnimatedSprite2D_Pawn:AnimatedSprite2D = null
#————————————————————
#下面四个方法都用StaticMachine来间接地统一管理
#————————————————————
#进入此状态时要初始化或提前准备的工作
func enter():
	pass
	
#离开当前状态时要执行的工作，多是销毁、回收、复位等
func exit():
	pass
	
#处于这个状态时要一直更新的动作	
#这里的update执行与否受状态机控制。
#如果不自己写而是调用系统自身的 _process则不受控制而无法管理
func update(delta:float):
	pass
	
#这个多用来处理输入事件
func physics_update(delta:float):
	pass
