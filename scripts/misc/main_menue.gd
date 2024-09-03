extends Node2D
var menu_stage = "start"

func _ready() -> void:
	$dificuly_select.hide()
	


func _on_start_pressed():
	menu_stage = "difficulty_select"
	$start.hide()
	$dificuly_select.show()


func _on_ez_pressed() -> void:
	Global.difficulty = "easy"
	get_tree().change_scene_to_file("res://scenes/levels/plains/start_ring.tscn")


func _on_normal_pressed() -> void:
	Global.difficulty = "normal"
	get_tree().change_scene_to_file("res://scenes/levels/plains/start_ring.tscn")


func _on_hard_pressed() -> void:
	Global.difficulty = "hard"
	get_tree().change_scene_to_file("res://scenes/levels/plains/start_ring.tscn")


func _on_jack_pressed() -> void:
	Global.difficulty = "jack"
	get_tree().change_scene_to_file("res://scenes/levels/plains/start_ring.tscn")
