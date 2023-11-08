extends State
#角色的移动速度，有很多技能可以加或减，因此最好能自定义
@export var SPEED = 300.0

func enter():
	#自有变量name，值为当前节点名，即Idle
	#注意写法，中间没有空格
	print("进入了状态%s"%name)
	#get_node("Area2D_PlayerBody/AnimatedSprite2D_Body")
	AnimatedSprite2D_Pawn.play("Idle_Normal")


func exit():
	print("离开当前状态%s"%name)

func update(delta):
	pass
	
func physics_update(delta):
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_down","ui_up")
	if directionX or directionY:
		#测试出来Y方向要加负号，这与全局按键设置有关
		var NormalizedVelocity = Vector2(directionX, -directionY).normalized()
		player.velocity = NormalizedVelocity * SPEED
	else:
		#如果轴值为0，则利用speed作为步长，将v.x往0方向移动。简单点说就是不输入则刹车减速至0
		player.velocity.x = move_toward(player.velocity.x, 0 , SPEED)
		player.velocity.y = move_toward(player.velocity.y, 0, SPEED)
		state_machine.emit_signal("transitioned", "run")
		player.move_and_slide()
		
	pass
