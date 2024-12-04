extends CharacterBody2D

const speed = 100
const jump_velocity = -250

var gravity = 900

var state
var state_factory

func _ready():
	state_factory = StateFactory.new()
	Idle()

func _process(_delta):
	
	var playerPos
	if has_node("../Player"):
		playerPos = get_node("../Player").position - self.position
	if playerPos.x >= -100:
		Shoot()
		print("Shoot")
	else:
		Idle()
		print ("Idle")
	

func _physicss_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func Shoot():
	change_state("shoot")
	state.Shoot()
	
func Idle():
	change_state("idle")
	state.idle()

func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup("change_state", $AnimationPlayer, self)
	state.name = "current_state"
	add_child(state)
	
