extends CharacterBody2D
class_name Player
@onready var state_machine:StateMachine = self.get_node("StateMachine")

var ghost_scene =  load("res://PingPong/Scenes/ghost.tscn")
@onready var sprite_2d = $Sprite2D
@onready var timer = $Timer

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

func add_ghost():
	var new_ghost = ghost_scene.instantiate()
	if new_ghost:
		print("dnf_mage 生成的ghost有效")
	new_ghost.set_new_position(position)
	new_ghost.set_scale(Vector2(0.3,0.3))
	print("sprite_2d的postition是%s" %sprite_2d.position)
	print("new_ghost 的postition是%s" %new_ghost.position)
	#sprite_2d.add_child(new_ghost)
	get_tree().current_scene.add_child(new_ghost)
	return


func _on_timer_timeout():
	print("时间到了")
	add_ghost()
	
	pass # Replace with function body.

