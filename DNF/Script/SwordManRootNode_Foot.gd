extends CharacterBody2D
class_name Player
@onready var state_machine:StateMachine = self.get_node("StateMachine")



func _physics_process(delta):
	
	pass
	
func _ready(): 
#	var anim_body_node = self.get_node("Area2D_PlayerBody/AnimatedSprite2D_Body")
#	anim_body_node.play("Battle_SheatheTheSword")
	pass


#这里要写扣血逻辑、是否被控制、其它负面效果，同时要更换状态机
func _on_area_2d_player_body_be_hit(damage):
	print("糟糕！我被击中了！本次扣除血量 %s" %damage)
	state_machine.emit_signal("transitioned", "Hurt")
	pass # Replace with function body.

