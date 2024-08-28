extends CharacterBody2D
#the initiation of the variables
var enemy_inattack_range = false
var enemy_type = "none"#approach the undeleatable gap
var health = 100
var damage = 20
var attack_cooldown = true

const speed = 100
var current_dirrection = "down"
var dashcooldown = true

func _ready():
	$AnimatedSprite2D.play("down idle")
	health = Global.player_max_health

func _physics_process(delta):
	player_movement(delta)
	attack()
	attackannimation()
	
	
	if health <= 0:
		print ("game over")
		health = 0
		queue_free()
		


	
	
func player_movement(delta):
	if Input.is_action_just_pressed("space"):
		dash(delta)
	elif Input.is_action_pressed("ui_right"):
		current_dirrection = "right"
		playanimation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dirrection = "left"
		playanimation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dirrection = "down"
		playanimation(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_dirrection = "up"
		playanimation(1)
		velocity.x = 0
		velocity.y = -speed
	
	else:
		playanimation(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
func player():
	pass
#dashing
# Called when the node enters the scene tree for the first time
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func dash(delta):
	var dir = current_dirrection
	if dashcooldown == true:
		if dir == "up":
			velocity.y = -1500
			velocity.x = 0
			dashcooldown = false
			$dashTimer.start
		if dir == "down":
			velocity.y = 1500
			velocity.x = 0
			dashcooldown = false
			$dashTimer.start
		if dir == "left":
			velocity.y = 0
			velocity.x = -1500
			dashcooldown = false
			$dashTimer.start
		if dir == "right":
			velocity.y = 0
			velocity.x = 1500
			dashcooldown = false
			$dashTimer.start
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
		if current_dirrection == "down":
			$"sword sprites/sword".play("Wood sword down")




func _on_weapon_cooldown_timeout():
	attack_cooldown = true
	Global.player_attacking = false
	
