extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D):
	if body is CharacterBody2D:
		print("your one time pass has been expird")
		timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
