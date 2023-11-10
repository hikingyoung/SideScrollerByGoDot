extends Area2D
var foot_collision_list:Array
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_foot_area_entered(area):
	foot_collision_list.append(area)
	print("有obj进入，名为%s" %area)
	var dic_size = foot_collision_list.size()
	print("当前符合进一步检测的对象有%s个，分别为：" %dic_size)
	for obj in foot_collision_list:
		if obj:
			print("----对象名为%s" %obj)
	pass # Replace with function body.


func _on_foot_area_exited(area):
	if foot_collision_list.has(area):
		foot_collision_list.erase(area)
	print("有obj退出")
	var dic_size = foot_collision_list.size()
	print("当前数组里还剩%s个元素" %dic_size)
	for obj in foot_collision_list:
		if obj:
			print("数组内剩下的对象是：")
			print("----对象：%s" %obj)
	pass # Replace with function body.


func _on_area_entered(area):
	if foot_collision_list.is_empty():
		return
	if foot_collision_list.has(area):
		pass
	pass # Replace with function body.
