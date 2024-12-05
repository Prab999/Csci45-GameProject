extends State
class_name ChaseState

var SPEED = 100

func _ready():
	Run()




func _physics_process(delta):
	if has_node ("../../player"):
		var Golem = get_parent()
		if Golem.chase == true:
			var player = get_node("../../player")
			var direction = (player.position - Golem.position).normalized()
			if direction.x > 0:
				get_node("../CharacterSheet").flip_h = false
			else:
				get_node("../CharacterSheet").flip_h = true
			Golem.velocity.x = direction.x * SPEED
		if Golem.shoot == true:
			Golem.velocity.x = 0
			Golem.change_state("attack")

func Run():
	animation.play("Run")

func exit():
	print("Exiting Chase state")
