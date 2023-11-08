extends State
@export var jump_velocity = -350
@export var swordman_gravity = 980
#一般来说跳跃位移要短一些，但也可以保持与地面位移一致
@export var move_speed_in_air = 200
#自写重力时每帧都需要计算位移，这个变量用来计数经过了多少个delta
var frame_counts = 1
#跳跃动作实际控制的节点，一定不是根节点。
#不可在定义时用get_node进行初始化，时机未到
@onready var child_node_for_jumping

# Called when the node enters the scene tree for the first time.
func _ready():
	child_node_for_jumping = get_node("../../Area2D_PlayerBody")
	pass # Replace with function body.


func enter():
	state_machine.is_in_air = true
	state_machine.is_on_floor = false
	state_machine.is_jumping = true
	AnimatedSprite2D_Pawn.play("JumpAndFall")
	pass

func exit():
	
	pass

func _process(delta):
	pass


func physics_update(delta):

	if child_node_for_jumping.position.y > 0:
		frame_counts =1
		child_node_for_jumping.position.y = 0
		state_machine.emit_signal("transitioned", "Idle")
		return
	child_node_for_jumping.position.y = jump_velocity * delta * frame_counts + 0.5 * swordman_gravity * pow(delta*frame_counts,2)
	frame_counts +=1
	
	#跳的时候应该可以选择方向，不写下面的代码将只能原地起跳
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_down","ui_up")
	var NormalizedVelocity = Vector2(directionX, -directionY).normalized()
	player.velocity = NormalizedVelocity * move_speed_in_air
	player.move_and_slide()
