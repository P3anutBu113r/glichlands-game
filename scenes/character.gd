extends CharacterBody2D

const speed = 100
var current_dirrection = "none"
func _ready():
	$AnimatedSprite2D.play("down idle")

func _physics_process(delta):
	player_movement(delta)
	
	
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
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
	
func playanimation(movement):
	var dir = current_dirrection
	var anim = $AnimatedSprite2D 
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("down idle")
		elif movement == 0:
			anim.play("down idle")
			
			#test
	elif dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("up idle")
		if movement == 0:
			anim.play("up idle")
	
	
