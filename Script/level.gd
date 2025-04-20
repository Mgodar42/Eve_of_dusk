extends Node2D

@onready var player: player = $player
@onready var animated_sprite_2d: AnimatedSprite2D = $Area2D/AnimatedSprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	$Area2D/AnimatedSprite2D.play("portalopen")
	if body is CharacterBody2D:
		get_tree().change_scene_to_file("res://Scene/end_panel.tscn")
		
