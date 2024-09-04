extends CharacterBody2D
class_name Player
#the initiation of the variables
var enemy_inattack_range = false
var enemy_type = "none"
var damage = 20
var attack_cooldown = true
var attack_animation = true
var player_hurt_active = false
var moving = true
var enemy = "body"
var currently_under_knockback = false
var current_weapon = "wood_sword"
var stamina_regen_cooldown = true
#approach the undeleatable gap

var speed = 100 
const acceleration = 5.0
var input: Vector2
var current_dirrection = "down"
var dashcooldown = true

func _ready():
	NavigationManager.on_trigger_player_spawn.connect(on_spawn)
	$AnimatedSprite2D.play("down idle")
	$"sword sprites".hide()
func on_spawn(position: Vector2, direction: String):
	global_position = position
	current_dirrection = direction

#ALL HAIL THE PHYSICS PROCESS
func _physics_process(delta):
	get_current_direction()
	player_movement(delta)
	attack()
	attackannimation()
	player_knockback(delta)
	change_current_weapon()
	health_processing()
	dodge()
	stamina_regen()

func get_input():
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()
func player_movement(delta):
	var player_input = get_input()
	


	if player_input == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		velocity = input * speed
	move_and_slide()
func health_processing():
	if Global.player_health <= 0:
		print ("game over")
		Global.player_health = 0
		queue_free()
func dodge():
	if Input.is_action_just_pressed("space"):
		dashcooldown = true
		if dashcooldown and Global.player_stamina > 25:
			speed = 200
			$dashTimer.start()
			Global.player_stamina = Global.player_stamina - 25
func get_current_direction():
	if Input.is_action_pressed("ui_up"):
		current_dirrection = "up"
		playanimation(1)
	elif Input.is_action_pressed("ui_down"):
		current_dirrection = "down"
		playanimation(1)
	elif Input.is_action_pressed("ui_left"):
		current_dirrection = "left"
		playanimation(1)
	elif Input.is_action_pressed("ui_right"):
		current_dirrection = "right"
		playanimation(1)
	else:
		playanimation(0)
	
	
#fun
func stamina_regen():
	if Global.player_stamina < 100 and stamina_regen_cooldown:
		stamina_regen_cooldown = false
		$stamina_regen_timer.start()
		
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
		if attack_cooldown == true and Global.player_stamina > 15:
			Global.player_attacking = true
			attack_cooldown = false
			Global.player_stamina = Global.player_stamina - 15
			
			
			
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


func _on_dash_timer_timeout():
	dashcooldown = false
	speed = 100


func _on_stamina_regen_timer_timeout():
	stamina_regen_cooldown = true
	Global.player_stamina = Global.player_stamina + 10
	print(Global.player_stamina)
