extends CharacterBody2D


class_name player

# Movement and physics
const SPEED = 45.0
const JUMP_VELOCITY = -150.0
const GRAVITY = 400.0  # Adjust as needed
const COYOTE_TIME = 0.1  # Allows brief jumping after falling

# Combat and health
@export var max_health: int = 100
var health: int = max_health
var is_dead: bool = false

# Node references
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var weapon: Sprite2D = $weapon

var can_jump = false
var is_attacking = false

func _physics_process(delta: float):
	if is_dead:
		return  # Stop processing if dead
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	
	# Handle jump input
	if can_jump and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		can_jump = false  # Reset after jumping

	# Handle horizontal movement
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip sprite based on movement direction
	if direction > 0:
		animated_sprite.flip_h = false
		weapon.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		weapon.flip_h = true

	# Handle animations
	if is_attacking:
		animated_sprite.play("shoot")
	elif direction == 0:
		animated_sprite.play("IDLE")
	else:
		animated_sprite.play("RUN")

	# Handle movement/deceleration
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Handle attack input
	if Input.is_action_just_pressed("ATTACK1"):
		attack()

func attack():
	if is_attacking:
		return  # Prevent attacking while already attacking
	
	is_attacking = true
	animated_sprite.play("ATTACK")
	weapon.visible = true  # Show weapon during attack
	
	# Attack duration timer
	$AttackTimer.start()

func _on_attack_timer_timeout():
	is_attacking = false
	weapon.visible = false  # Hide weapon after attack

func take_damage(amount: int):
	if is_dead:
		return
	
	health -= amount
	
	# Play hurt animation if available
	animated_sprite.play("HURT")
	
	if health <= 0:
		die()

func die():
	is_dead = true
	animated_sprite.play("DEAD")
	velocity = Vector2.ZERO  # Stop movement
	return_to_scene()

func return_to_scene():
	# Delay the restart to allow the death animation to play if you want
	await get_tree().create_timer(2.0).timeout  # 2 seconds delay
	get_tree().reload_current_scene()  # Reload the current scene # Disable further movement
	
