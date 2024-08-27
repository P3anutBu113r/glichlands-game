extends CharacterBody2D

const speed = 100
var current_dirrection = "down"
var dashcooldown = true
func _ready():
	$AnimatedSprite2D.play("down idle")

func _physics_process(delta):
	player_movement(delta)


	
	
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
		

	
	
	
