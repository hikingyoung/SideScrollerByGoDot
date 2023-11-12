#这个判定场景主要用于常规人物，常规弹道等的判定
#第一步先判定地面的足部框能不能碰撞，类似3D游戏中的XY平面判定，类似天空视角topdown
#第二步判定地上的身体框能不能碰撞，类似3D游戏中的XZ平面判定，视角类似侧面平台跳跃
#已知缺陷1：
#1.大表面积低身位的怪，如像地毯一样的怪，Body设置得大，空中技能打到会不合常理。
#2.领域技能会导致无法跳过，如熔岩药瓶，或天帷禁地掉在地表的岩液
#3.第1次判定会有上下沿站位问题。打点低的技能在下沿可能打不到怪；打点高的技能在上沿同理；3D世界不会发生
#4.为了解决第3点，可以把Body碰撞框故意拉大，但这将导致出现2中的跳跃问题。在下沿需要跳更高的高度才能跃过，甚至上能跳过下跳不过
#优化方案：第一段碰撞保留，第二次判定由碰撞变成纯粹比较数值，跳跃组件的y坐标

extends State

@export var jump_velocity:float = -350.00
@export var swordman_gravity:float = 980
#一般来说跳跃位移要短一些，但也可以保持与地面位移一致
@export var move_speed_in_air = 200
#自写重力时每帧都需要计算位移，这个变量用来计数经过了多少个delta
var frame_counts = 1
#脚下阴影
var shadow_scale_ratio = 1
var shadow_sprite2D:Sprite2D
var max_jump_up_time:float =0
var max_jump_height:float =0
var current_scale:Vector2
#跳跃动作实际控制的节点，一定不是根节点。
#不可在定义时用get_node进行初始化，时机未到
@onready var child_node_for_jumping

# Called when the node enters the scene tree for the first time.
func _ready():
	child_node_for_jumping = get_node("../../Area2D_PlayerBody")
	shadow_sprite2D = get_node("../../CollisionShape2D_Foot/Location_Foot")
	#跳至最高点的时间
	max_jump_up_time = abs(jump_velocity / swordman_gravity)
	#最高点的位移. 注意了，尤其引擎坐标轴的设定原因，算出来的值是负的，要进行纠正以方便理解
	max_jump_height =abs(jump_velocity*max_jump_up_time + 0.5*swordman_gravity*pow(max_jump_up_time,2))
	current_scale = shadow_sprite2D.get_scale()
func enter():
	state_machine.is_in_air = true
	state_machine.is_jumping = true
	AnimatedSprite2D_Pawn.play("jump_76_83")
	pass

func exit():
	state_machine.is_in_air = false
	state_machine.is_jumping = false
	pass

func _process(delta):
	pass


func physics_update(delta):
	#落地时，由于重力关系还会往下一点，此时y>0，强制将y归0，所有与跳相关的变量初始化，切换状态
	if child_node_for_jumping.position.y > 0:
		frame_counts =1
		child_node_for_jumping.position.y = 0
		state_machine.emit_signal("transitioned", "Idle")
		return
	#根据加速度位移公式更新跳跃组件的y位置	
	child_node_for_jumping.position.y = jump_velocity * delta * frame_counts + 0.5 * swordman_gravity * pow(delta*frame_counts,2)
	frame_counts +=1

	#根据当前跳跃高度来映射缩放比例
	shadow_scale_ratio = remap(abs(child_node_for_jumping.position.y), 0, max_jump_height, 1, 0.5)
	shadow_sprite2D.set_scale(shadow_scale_ratio * current_scale)
	
	#跳的时候应该可以选择跳跃的目的地，不写下面的代码将只能原地起跳
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_down","ui_up")
	var NormalizedVelocity = Vector2(directionX, -directionY).normalized()
	player.velocity = NormalizedVelocity * move_speed_in_air
	player.move_and_slide()
