extends CharacterBody2D
var speed = 75
var player_chase = false
var player = null
@onready var anim = $AnimatedSprite2D
func _ready():
	$AnimatedSprite2D.play("slime_idle")
func _physics_process(delta):
	if player_chase:

		position += (player.position - position).normalized() * speed * delta
		move_and_collide(Vector2(0,0)) 
		anim.play("slime_jump")
		if(player.position.x - position.x) < 0:
			anim.flip_h = true
		else:
			anim.flip_h = false
	else:
		anim.play("slime_idle")
		

#chaotic slime thats fast as f**k
	#if player_chase:
		#position += (player.position - position)/speed
		#move_and_slide()
		


func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true
	


func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player = null
		player_chase = false
	
