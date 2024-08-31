extends CharacterBody2D
#the initiation of the variables
var enemy_inattack_range = false
var enemy_type = "none"
var health = 100
var damage = 20
var attack_cooldown = true
var attack_animation = true
var player_hurt_active = false
var moving = true
var enemy = "body"
var currently_under_knockback = false
var current_weapon = "wood_sword"
#approach the undeleatable gap

const SPEED = 100 
const acceleration = 5
var input: Vector2
var current_dirrection = "down"
var dashcooldown = true

func _ready():
	$AnimatedSprite2D.play("down idle")
	health = Global.player_max_health
	$"sword sprites".hide()

#ALL HAIL THE PHYSICS PROCESS
func _physics_process(delta):
	get_current_direction()
	player_movement(delta)
	attack()
	attackannimation()
	player_knockback(delta)
	change_current_weapon()
	health_processing()
func get_input():
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input.normalized()
func player_movement(delta):
	var player_input = get_input()
	if player_input == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		velocity = input * SPEED
	
	move_and_slide()
func health_processing():
	$healthbar.value = health
	if health >= Global.player_max_health:
		$healthbar.hide()
	else:
		$healthbar.show()
	if health <= 0:
		print ("game over")
		health = 0
		queue_free()
	
func get_current_direction():
	if Input.is_action_pressed("ui_left"):
		current_dirrection = "left"
		playanimation(1)
	elif Input.is_action_pressed("ui_right"):
		current_dirrection = "right"
		playanimation(1)
	elif Input.is_action_pressed("ui_up"):
		current_dirrection = "up"
		playanimation(1)
	elif Input.is_action_pressed("ui_down"):
		current_dirrection = "down"
		playanimation(1)
	else:
		playanimation(0)
	
	
#fun

func player():
	pass
#dashing
# Called when the node enters the scene tree for the first time

func player_knockback(delta):
	if player_hurt_active:
		player_hurt_active = false
		currently_under_knockback = true
		$player_hurt_timer.start()
		if currently_under_knockback:
			moving = false
			position -= (enemy.position - position).normalized() * 200 * delta
			move_and_collide(Vector2(0,0)) 
			if current_dirrection == "down":
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("hurt_down")
			if current_dirrection == "left":
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("side_hurt")
			if current_dirrection == "right":
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("side_hurt")
			if current_dirrection == "up":
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("up_hurt")
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	dashcooldown = true

func playanimation(movement):
	var dir = current_dirrection
	var anim = $AnimatedSprite2D 
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("down walk")
		elif movement == 0:
			anim.play("down idle")
	elif dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("up walk")
		if movement == 0:
			anim.play("up idle")
	elif dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.flip_h = true
			anim.play("side walk")
		if movement == 0:
			anim.play("side idle")
	elif dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.flip_h = false
			anim.play("side walk")
		if movement == 0:
			anim.play("side idle")
	
func _on_combat_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		if body.has_method("green_slime"):
			enemy_type = ("green_slime")
			enemy = body

func _on_combat_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		
func attack():
	if Input.is_action_just_pressed("attack"):
		if attack_cooldown == true:
			Global.player_attacking = true
			attack_cooldown = false
			
			
			
			$weapon_cooldown.start()

func attackannimation():
	if Global.player_attacking:
		$"sword sprites".show()
		if current_dirrection == "down":
			Global.player_attack_dirrection = "down"
			$"sword sprites/sword".play("Wood sword down")
		if current_dirrection == "up":
			Global.player_attack_dirrection = "up"
			$"sword sprites/sword".play_backwards("Sword up")
		if current_dirrection == "right":
			Global.player_attack_dirrection = "right"
			$"sword sprites/sword".play("left sword")
		if current_dirrection == "left":
			Global.player_attack_dirrection = "left"
			$"sword sprites/sword".play("sword right")

func _on_weapon_cooldown_timeout():
	attack_cooldown = true
	Global.player_attacking = false
	
func change_current_weapon():
	if current_weapon == "wood_sword":
		damage = 10
		$weapon_cooldown.wait_time = 0.5

func _on_sword_animation_finished(anim_name):
	$"sword sprites".hide()

func _on_player_hurt_timer_timeout():
	player_hurt_active = false
	moving = true
	currently_under_knockback = false
	print("timer_working")
