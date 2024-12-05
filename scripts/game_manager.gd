extends Node

var score = 0

func add_point():
	score +=1
	print(score)
	if score == 6:
		get_tree().change_scene_to_file("res://scenes/boss_fight.tscn")
