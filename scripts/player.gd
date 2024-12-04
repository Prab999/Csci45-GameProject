extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var is_crouching = false

const SPEED = 130.0
const jump_power = -300.0

var gravity = 900

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power
		animated_sprite.play("jump")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("crouch"):
		crouch()
	elif Input.is_action_just_released("crouch"):
		stand()

	move_and_slide()
	handle_movement_animation(direction)
	

func handle_movement_animation(direction):
	if is_on_floor():
		if !velocity:
			if is_crouching:
				animated_sprite.play("crouch")
			else:
				animated_sprite.play("idle")
		if velocity:
			if is_crouching:
				animated_sprite.play("crouch_walk")
			else:
				animated_sprite.play("run")
			toggle_flip_sprite(direction)
	elif !is_on_floor():
		if is_crouching == false:
			if velocity.y < 0:
				animated_sprite.play("jump")
			elif velocity.y > 0:
				animated_sprite.play("fall")
		if is_crouching == true:
			if velocity.y < 0:
				animated_sprite.play("jump")
			elif velocity.y > 0:
				animated_sprite.play("crouch")
		
func toggle_flip_sprite(direction):
	if direction == 1:
		animated_sprite.flip_h = false
	if direction == -1:
		animated_sprite.flip_h = true

func crouch():
	if is_crouching:
		return
	is_crouching = true

func stand():
	if is_crouching == false:
		return
	is_crouching = false
