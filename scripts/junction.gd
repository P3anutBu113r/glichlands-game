extends Node2D

func _ready():
	firstload()
func _physics_process(delta):
	change_scene_flower_ring()
	


func _on_flower_ring_transition_body_entered(body):
	if body.has_method("player"):
		$CharacterBody2D.position.x = 108
		$CharacterBody2D.position.y = 191
		Global.transition_scene = true


func _on_flower_ring_transition_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false
	
func change_scene_flower_ring():
	if Global.transition_scene == true:
		if Global.current_scene == "junction":
			Global.finish_changescenes()
			get_tree().change_scene_to_file("res://scenes/flower_ring.tscn")
func firstload():
	if Global.firstjunctionload == true:
		$CharacterBody2D.position.x = -279
		$CharacterBody2D.position.y = -215
		print("pain")
		Global.firstjunctionload = false
	else:
		$CharacterBody2D.position.x = Global.flower_ring_exit_x
		$CharacterBody2D.position.y = Global.flower_ring_exit_y
	
