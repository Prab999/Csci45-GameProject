extends Node2D

@onready var temp_coin: Area2D = $tempCoin


func _process(delta: float) -> void:
	pass



func _on_temp_coin_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/level_one.tscn")
