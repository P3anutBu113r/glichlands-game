extends CharacterBody2D

@export var speed = 100
var player_chase = false
var player = null
var combat = false
var attack_cooldown = true
var player_in_attack_zone = false
var health = 100
var moving = true
var warning = false
var alert_animation = false
var close_stop = false



@onready var anim = $AnimatedSprite2D
func _ready():
	$AnimatedSprite2D.play("slime_idle")
func _physics_process(delta):
	
	attack()
	movement(delta)
	take_damage()
	if alert_animation:
		$AnimatedSprite2D.play("slime_aleart")
		
	if health <= 0:
		print("slime dead")
		queue_free()

func movement(delta):
	if player_chase and moving and close_stop == false:
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
		close_stop = true

func attack():
	if combat and attack_cooldown:
		$"warning timer".start() 
		alert_animation = true
		moving = false
		attack_cooldown = false
		print("slime stage 1")

func attack_stage_2():
	alert_animation = false
	$"attack cooldown".start()
	warning = false
	moving = true
	if player_in_attack_zone:
		player.health = player.health - 10
		print("your health is ", player.health)

func _on_combat_hitbox_body_exited(body):
	if body.has_method("player"):
		combat = false
		player_in_attack_zone = false
		close_stop = false


func _on_attack_cooldown_timeout():
	attack_cooldown = true
	

func take_damage():
	if player_in_attack_zone and Global.player_attacking == true:
		health = health - player.damage
		Global.player_attacking = false
		print("the slimes health is ", health)
		
		


func _on_hurt_range_body_entered(body):
	if body.has_method("player"):
		player_in_attack_zone = true


func _on_hurt_range_body_exited(body):
	if body.has_method("player"):
		player_in_attack_zone = false


func _on_warning_timer_timeout():
	print("warning_timer_timeout")
	attack_stage_2()
