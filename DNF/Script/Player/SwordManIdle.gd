extends State

func enter():
	print("进入了状态%s"%name)
	state_machine.is_on_floor = true
	AnimatedSprite2D_Pawn.play("idle_10_13")


func exit():
	print("离开当前状态%s"%name)
	state_machine.is_on_floor = false
	pass

func handle_input(event):
	
	
	if Input.is_action_just_pressed("Jump"):
#		state_machine.emit_signal("transitioned","Jump")
		state_machine.emit_signal("transitioned","Jump")
		return
	
	if Input.is_action_just_pressed("Attack"):
		state_machine.emit_signal("transitioned", "Attack01_On_Floor")
		return
	
	pass

func update(delta):
	pass
	
func physics_update(delta):
	#写在handle_input中能在地面正常跑起来，但如果在跳跃中不松键则无法维持跑动
	axis_value_X = Input.get_axis("ui_left", "ui_right")
	axis_value_y = Input.get_axis("ui_down","ui_up")
	if (axis_value_X or axis_value_y):
		state_machine.emit_signal("transitioned", "Run")
		return
	pass

