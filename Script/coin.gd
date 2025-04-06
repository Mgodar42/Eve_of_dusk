extends Area2D

@onready var game_manager: Node+ %GAmeManager
@onready var animation_player: AnimationPlayer + $AnimationPlayer 



func _on_body_entered(body: Node2D):
	
	ggame_manager.add_point()
	animation_player.play("pickup")
