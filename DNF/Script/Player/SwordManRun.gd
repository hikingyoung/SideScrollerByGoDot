extends State

func enter():
	print("进入了状态%s"%name)
	AnimatedSprite2D_Pawn.play("Run")
func exit():
	print("离开当前状态%s"%name)
