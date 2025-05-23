extends Node2D


const speed = 60
var health = 3
var is_alive = true
var direction =1

@onready var ray_castright: RayCast2D = $RayCastright
@onready var ray_castleft: RayCast2D = $RayCastleft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var kitsune: player = $"../kitsune"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_castright.is_colliding():
		direction = -1
		animated_sprite.flip_h = false
	if ray_castleft.is_colliding():
		direction = 1
		animated_sprite.flip_h = true
	position.x += delta*speed*direction
	


func _on_area_2d_body_entered(body):
	if (body.name == "kitsune"):
		var y_delta = position.y - body.position.y
		if (y_delta> 30):
			queue_free()
		else: 
			get_tree().reload_current_scene()
