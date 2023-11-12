extends State

var is_continue =  false
#最小攻击间隔, 后期可由攻击速度来降低
var min_attack_interval:float = 0.6
#最大动画演出时间，当前角色三下攻击帧数分别为5、6、6，每秒播8帧，所以最大用时是6/8=0.75秒
var max_anim_time:float = 0.75
#攻击时轻微地，向前移动
var move_while_attacking = 50

func enter():
	print("进入了状态%s"%name)
	state_machine.is_in_battle = true
	state_machine.is_on_floor = true
	AnimatedSprite2D_Pawn.play("attack3rd_35_41")
	#创建计时器，创建成功后将自动运行
	var timer = get_tree().create_timer(max_anim_time,false, true)
	#绑定默认的信号
	timer.connect("timeout", Callable(self, "do_combo"))
	#如果这里写 await timer.timeout，则意味着强制等1秒钟，
	#后面的代码延后1秒执行，就像UE中的delay
	pass
	
func exit():
	is_continue = false
	state_machine.is_in_battle = false
	state_machine.is_on_floor = false
	print("离开当前状态%s"%name)
	pass
	
func physics_update(delta):
	axis_value_X = Input.get_axis("ui_left","ui_right")
	if axis_value_X:
		#为真时面向左
		if AnimatedSprite2D_Pawn.flip_h:
			player.velocity = Vector2(-1,0) * move_while_attacking
			player.move_and_slide()
		else:
			#注意了，向右移动时向量不是（0，1），是（1，0）
			player.velocity = Vector2(1, 0) * move_while_attacking
			player.move_and_slide()
	else:
		#move_while_attack此时代表刹车加速度
		player.velocity.x =move_toward(player.velocity.x, 0, move_while_attacking)
	pass

func handle_input(event):
	print("第3下攻击尚未结束，请等待重置")
	pass
	
func do_combo():
	if is_continue:
		#正常角色不会有第4下攻击，如有需要再在这里拓展
		pass
	else:
#		await get_tree().create_timer(max_anim_time-min_attack_interval, false, true).timeout
		state_machine.emit_signal("transitioned", "Idle")
	pass
