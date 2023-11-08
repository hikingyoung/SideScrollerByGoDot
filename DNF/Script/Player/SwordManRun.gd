extends State
@export var run_speed = 300
func enter():
	print("进入了状态%s"%name)
	AnimatedSprite2D_Pawn.play("Run")
	#下面这串代码用来解决这种情况：向前跳跃，但在落地前，按住向后的按键。不写下面的代码，落地后将会退着跑
	if Input.is_action_pressed("ui_right"):
		AnimatedSprite2D_Pawn.flip_h = false
	if Input.is_action_pressed("ui_left"):
		AnimatedSprite2D_Pawn.flip_h = true
	
func exit():
	player.velocity.x = move_toward(player.velocity.x, 0 , 300)
	player.velocity.y = move_toward(player.velocity.y, 0, 300)
	print("离开当前状态%s"%name)

func _input(event):
	#在移动时根据按键翻转精灵图片
	#在空中不能转向，只有在平地才可以
	if state_machine.is_on_floor :
		if event.is_action_pressed("ui_right"):
			AnimatedSprite2D_Pawn.flip_h = false
			print("翻转功能未被执行")
		if event.is_action_pressed("ui_left"):
			AnimatedSprite2D_Pawn.flip_h = true
			print("翻转功能被执行了")
func physics_update(delta):
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up","ui_down")
	
	#满足下面的条件，切换至空闲状态
	if !directionX and !directionY and state_machine.is_on_floor:
		#如果轴值为0，则利用speed作为步长，将v.x往0方向移动。简单点说就是不输入则刹车减速至0
		player.velocity.x = move_toward(player.velocity.x, 0 , run_speed)
		player.velocity.y = move_toward(player.velocity.y, 0, run_speed)
		state_machine.emit_signal("transitioned", "Idle")
		return
	#跑动状态也能切换到跳
	if Input.is_action_just_pressed("Jump"):
		state_machine.emit_signal("transitioned","Jump")
		return
	#真正的跑起来逻辑
	var NormalizedVelocity = Vector2(directionX, directionY).normalized()
	player.velocity = NormalizedVelocity * run_speed
	player.move_and_slide()
	
