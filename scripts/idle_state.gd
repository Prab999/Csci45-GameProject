extends State
class_name IdleState


func _ready():
	get_parent().velocity.x = 0
	idle()

func idle():
	animation.play("Idle")
 

func exit():
	print("Exiting Idle state")
