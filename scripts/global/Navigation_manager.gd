extends Node

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"flower_ring":
			scene_to_load = "res://scenes/levels/plains/flower_ring.tscn"
		"junction":
			scene_to_load = "res://scenes/levels/plains/junction.tscn"
		"start_ring":
			scene_to_load = "res://scenes/levels/plains/start_ring.tscn"
		"combat_tutorial":
			scene_to_load = "res://scenes/levels/plains/combat_tutorial.tscn"
			
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_file(scene_to_load)
	
func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
		
