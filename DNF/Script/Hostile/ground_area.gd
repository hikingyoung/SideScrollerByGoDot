extends Area2D
#专门解决低身位的领域技能判定问题，第一段判定类似3d世界XY平面，第二段变为纯比较数值
@export var effective_height:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	#比较目标跳跃的高度，要求目标跳跃组件名为Body，且有TRANSFORM属性
	if abs(area.Body.position.y) <= effective_height:
		#要求目标有信号be_hit,且连接了方法，该方法接收一个int类型的型参。
		area.emit_signal("be_hit", "10")
	pass # Replace with function body.
