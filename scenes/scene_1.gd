extends Node2D


# Called when the node enters the scene tree for the first time.
var carscene : PackedScene = preload("res://car.tscn")
var score: int





func go_title():
	get_tree().change_scene_to_file("res://interface_1.tscn")






func _on_cartimer_timeout() -> void:
	var car = carscene.instantiate() as CharacterBody2D
	var pos_marker = $carpositions.get_children().pick_random() as Marker2D
	car.position = pos_marker.position
	$objects.add_child(car)
	
	




func _on_scoretimer_timeout() -> void:
	score += 1
	$CanvasLayer/Label.text = "score: " + str(score)
