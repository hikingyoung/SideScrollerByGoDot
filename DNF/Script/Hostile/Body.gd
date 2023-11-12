extends Area2D
var foot_collision_list:Array
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_foot_area_entered(area):
	#将碰撞到的foot对应的Body传进来并存储
	foot_collision_list.append(area.Body)
	print("有obj进入，名为：%s" %area)
	print("该obj对应的body名为：%s,其已被加入容器中" %area.Body)
	var dic_size = foot_collision_list.size()
	print("当前符合进一步检测的对象有%s个，分别为：" %dic_size)
	for obj in foot_collision_list:
		if obj:
			print("----对象名为%s" %obj)
	pass # Replace with function body.


func _on_foot_area_exited(area):
	#无需使用array.has()方法，因为系统会在erase时自动判断有效性，没有时什么都不发生
	foot_collision_list.erase(area.Body)
	print("有obj退出")
	var dic_size = foot_collision_list.size()
	print("当前数组里还剩%s个元素" %dic_size)
	for obj in foot_collision_list:
		if obj:
			print("数组内剩下的对象是：")
			print("----对象：%s" %obj)
	pass # Replace with function body.

#因为检测通道的预先设置，这里的area一定是ally的body部分,无须再进行任何转化
func _on_area_entered(area):
	if foot_collision_list.is_empty():
		return
	#被碰撞到了，应该写玩家的硬直、扣血等逻辑	
	if foot_collision_list.has(area):
		print("子弹击中了%s" %area)
		#只要求对方有be_hit信号即可，做到了解耦。
		area.emit_signal("be_hit", 10)
		pass
	pass # Replace with function body.


func _on_area_exited(area):
	
	pass # Replace with function body.

