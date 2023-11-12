extends State
@export var run_speed = 300

func enter():
	state_machine.is_on_floor = true
	print("进入了状态%s"%name)
	AnimatedSprite2D_Pawn.play("run_18_21")
	#下面这串代码用来解决这种情况：向前跳跃，但在落地前，按住向后的按键。不写下面的代码，落地后将会退着跑
	if Input.is_action_pressed("ui_right"):
		AnimatedSprite2D_Pawn.flip_h = false
		Animated_Weapon.flip_h = false
		Animated_Weapon.position = Vector2(-2,-10)
	if Input.is_action_pressed("ui_left"):
		AnimatedSprite2D_Pawn.flip_h = true
		Animated_Weapon.flip_h = true
		Animated_Weapon.position = Vector2(70,-10)
func exit():
	state_machine.is_on_floor = false
	player.velocity.x = move_toward(player.velocity.x, 0 , 300)
	player.velocity.y = move_toward(player.velocity.y, 0, 300)
	print("离开当前状态%s"%name)

func handle_input(event):
	#在移动时根据按键翻转精灵图片
	#在空中不能转向，只有在平地才可以
	if event.is_action_pressed("ui_right"):
		#为false时面向右
		AnimatedSprite2D_Pawn.flip_h = false
		Animated_Weapon.flip_h = false
		Animated_Weapon.position = Vector2(-2,-10)
	if event.is_action_pressed("ui_left"):
		#为true时面向左
		AnimatedSprite2D_Pawn.flip_h = true
		Animated_Weapon.flip_h = true
		Animated_Weapon.position = Vector2(70,-10)
	#跑动状态也能切换到跳
	if Input.is_action_just_pressed("Jump"):
		print("Jump被按了")
		state_machine.emit_signal("transitioned","Jump")
		return	
	if Input.is_action_just_pressed("Attack"):
		state_machine.emit_signal("transitioned", "Attack01_On_Floor")
		return	
func physics_update(delta):
	
	#轴值必须时刻监听
	axis_value_X = Input.get_axis("ui_left", "ui_right")
	axis_value_y = Input.get_axis("ui_up","ui_down")
	
	#满足下面的条件，切换至空闲状态
	#这个状态也必须时刻监听，不能依赖输入事件的按下，因为它们往往只检测按下的那帧
	#如果写在hand_input中，则无法检测到其变为0的时刻
	if !axis_value_X and !axis_value_y :
		#如果轴值为0，则利用speed作为步长，将v.x往0方向移动。简单点说就是不输入则刹车减速至0
		player.velocity.x = move_toward(player.velocity.x, 0 , run_speed)
		player.velocity.y = move_toward(player.velocity.y, 0, run_speed)
		state_machine.emit_signal("transitioned", "Idle")
		return
	
	
	#真正的跑起来逻辑
	var NormalizedVelocity = Vector2(axis_value_X, axis_value_y).normalized()
	player.velocity = NormalizedVelocity * run_speed
	player.move_and_slide()
	
