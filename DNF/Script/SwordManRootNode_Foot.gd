extends CharacterBody2D
class_name Player
const SPEED = 300.0

func _physics_process(delta):

#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var directionX = Input.get_axis("ui_left", "ui_right")
#	var directionY = Input.get_axis("ui_down","ui_up")
#	if directionX or directionY:
#		#测试出来Y方向要加负号，这与全局按键设置有关
#		var NormalizedVelocity = Vector2(directionX, -directionY).normalized()
#		velocity = NormalizedVelocity * SPEED
#	else:
#		#如果轴值为0，则利用speed作为步长，将v.x往0方向移动。简单点说就是不输入则刹车减速至0
#		velocity.x = move_toward(velocity.x, 0 , SPEED)
#		velocity.y = move_toward(velocity.y, 0, SPEED)
#	move_and_slide()

	pass
	
func _ready():
#	var anim_body_node = self.get_node("Area2D_PlayerBody/AnimatedSprite2D_Body")
#	anim_body_node.play("Battle_SheatheTheSword")
	pass
