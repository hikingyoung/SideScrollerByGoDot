extends Area2D

@export var JUMP_VELOCITY = -300.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var InAir = false
var DeltaCounts = 1;
func _physics_process(delta):
#	# Add the gravity.
##	if not is_on_floor():
##		velocity.y += gravity * delta
#	if position.y < 0 :
#		InAir = true
#	else:
#		position.y = 0
#		InAir = false
#		DeltaCounts = 1
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and !InAir:
#		InAir = true
#	if InAir:
#		position.y = JUMP_VELOCITY * delta * DeltaCounts + 0.5 * gravity * pow(delta*DeltaCounts,2)	
#		DeltaCounts +=1
	pass
