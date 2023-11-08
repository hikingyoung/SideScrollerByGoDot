extends State
#角色的移动速度，有很多技能可以加或减，因此最好能自定义
@export var SPEED = 300.0

func enter():
	print("进入了状态%s"%name)
	state_machine.is_on_floor = true
	state_machine.is_jumping = false
	AnimatedSprite2D_Pawn.play("Idle_Normal")


func exit():
	print("离开当前状态%s"%name)
	pass

func update(delta):
	pass
	
func physics_update(delta):
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_down","ui_up")
	if (directionX or directionY) and state_machine.is_on_floor:
		print("即将切换到Run状态")
		state_machine.emit_signal("transitioned", "Run")
		return
		
	if Input.is_action_just_pressed("Jump"):
		state_machine.emit_signal("transitioned","Jump")
		return
