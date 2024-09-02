extends Node

var current_scene = "junction"
var transition_scene = false
func _physics_process(delta):
	null
var firstjunctionload = true
var player_max_health = 100
var player_attacking = false
var player_attack_dirrection = "none"
var flower_ring_exit_x = 108
var flower_ring_exit_y = 193
var player_health = player_max_health

func finish_changescenes():
	if transition_scene == true:
		if current_scene =="junction":
			current_scene = "flower_ring"
		elif current_scene == "flower_ring":
			current_scene = "junction"
	
	elif transition_scene == false:
		current_scene = "junction"
		
	
	
