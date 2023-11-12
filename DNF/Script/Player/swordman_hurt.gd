extends State
var recover_time:float = 0.5
func enter():
	print("进入了状态%s"%name)
	state_machine.is_in_battle = true
	state_machine.is_taking_hurt = true
	#在休闲帧中处理，未来可能有隐患，先在这里标记一下
	AnimatedSprite2D_Pawn.set_self_modulate(Color8(255,150,150,255))
	AnimatedSprite2D_Pawn.play("be_hit_128_131")
	var timer = get_tree().create_timer(recover_time, 0)
	timer.connect("timeout", Callable(self, "recovering"))
func exit():
	print("离开当前状态%s"%name)
	state_machine.is_in_battle = false
	state_machine.is_taking_hurt = false
	AnimatedSprite2D_Pawn.set_self_modulate(Color(1,1,1,1))
#进入这个状态后就要等待恢复，如果继续受到伤害以最后一击能造成的硬直为准
func update(delta):

	pass
	
func recovering():
	state_machine.emit_signal("transitioned", "Idle")
