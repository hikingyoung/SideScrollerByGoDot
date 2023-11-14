extends CharacterBody2D

var ghost_scene =  load("res://PingPong/Scenes/ghost.tscn")
@onready var timer = $Timer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func add_ghost():
	var ghost = ghost_scene.instantiate()
	ghost.set_new_position(position)
	print(position)
	get_tree().current_scene.add_child(ghost)
	return


func _on_timer_timeout():
	add_ghost()
	pass # Replace with function body.
