extends CharacterBody2D
@export var speed = 50
var player_chase = false
var player = null
var combat = false
var attack_cooldown = true
var player_in_attack_zone = false
var health = 100
@onready var anim = $AnimatedSprite2D
func _ready():
	$AnimatedSprite2D.play("slime_idle")
func _physics_process(delta):
	attack()
	movement(delta)

		

#chaotic slime thats fast as f**k
	#if player_chase:
		#position += (player.position - position)/speed
		#move_and_slide()
		
func movement(delta):
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

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true
#calling the identifying meathods since its the best way i know
	
func enemy():
	null
func green_slime():
	null

func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player = null
		player_chase = false
	


func _on_combat_hitbox_body_entered(body):
	if body.has_method("player"):
		combat = true
		player_in_attack_zone = true

func attack():
	if combat and attack_cooldown:
		player.health = player.health - 10
		attack_cooldown = false
		$"attack cooldown".start()
		print("your health is ", player.health)
		


func _on_combat_hitbox_body_exited(body):
	combat = false
	player_in_attack_zone = false


func _on_attack_cooldown_timeout():
	attack_cooldown = true

func take_damage():
	if player_in_attack_zone and Global.player_attacking:
		health = health - player.damage
		
