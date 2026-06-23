extends CharacterBody2D

const speed = 100
var current_direction = "none"

func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta: float) -> void:
	player_movement(delta)
	
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		play_animation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		play_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -speed
	elif Input.is_action_pressed("ui_down"):
		current_direction = "down"
		play_animation(1)
		velocity.x = 0
		velocity.y = speed 
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
func play_animation(move):
	var direction = current_direction
	var animation = $AnimatedSprite2D
	
	if direction == "right" :
		animation.flip_h = false 
		if move == 1 :
			animation.play("side_walk")
		elif move == 0 :
			animation.play("side_idle")
			
	if direction == "left" :
		animation.flip_h = true
		if move == 1:
			animation.play("side_walk")
		elif move == 0:
			animation.play("side_idle")
			
	if direction == "up":
		if move == 1:
			animation.play("back_walk")
		elif move == 0:
			animation.play("back_idle")
			
	if direction == "down":
		if move == 1:
			animation.play("front_walk")
		elif move == 0 :
			animation.play("front_idle")
