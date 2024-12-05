extends State
class_name AttackState

func _ready():
	var anim = get_node("../AnimationPLayer")
	#anim.connect("animation_finished", _on_animation_finised)
	anim.animation_finished.connect(Callable(self, "_on_animation_finished"))
	Shoot()

func Shoot():
	animation.play("Shoot")

func _on_animation_finished(anim_name):
	if (anim_name == "Shoot") or (anim_name == "MeleeAttack"):
		if get_parent().shoot == true:
			animation.play("Shoot")
		elif get_parent().melee == true:
			animation.play("MeleeAttack")


func exit():
	print("Exiting Attack state")
