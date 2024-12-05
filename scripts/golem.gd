extends CharacterBody2D

const SPEED = 100
const jump_velocity = -250

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var state
var state_factory
var chase = false
var melee = false
var shoot = false

func _ready():
	state_factory = StateFactory.new()
	change_state("idle")


func _physicss_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()


func change_state(new_state_name):
	if state != null:
		state.exit()
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup("change_state", $AnimationPlayer, self)
	state.name = "current_state"
	add_child(state)
	


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.name == "player":
		chase = true
		change_state("chase")


func _on_player_detector_body_exited(body: Node2D) -> void:
	if body.name == "player":
		chase = false
		change_state("idle")


func _on_melee_player_detector_body_entered(body: Node2D) -> void:
	if body.name == "player":
		melee = true
		shoot = false

func _on_melee_player_detector_body_exited(body: Node2D) -> void:
	if body.name == "player":
		melee = false
		shoot = true

func _on_shoot_player_detector_body_entered(body: Node2D) -> void:
	if body.name == "player":
		melee = false
		shoot = true


func _on_shoot_player_detector_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player":
		melee = false
		shoot = false
		change_state("chase")
