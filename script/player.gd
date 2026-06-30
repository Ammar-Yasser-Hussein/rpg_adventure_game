extends CharacterBody2D

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 160
var player_alive = true

const speed = 100
var current_direction = "none"


var attack_ip = false



func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta: float) -> void:
	player_movement(delta)
	ememy_attack()
	attack()
	
	if health <= 0:
		player_alive = false
		print("player has been killed")
		self.queue_free()

func player_movement(delta):
	if Input.is_action_pressed("right"):
		current_direction = "right"
		play_animation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("left"):
		current_direction = "left"
		play_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("up"):
		current_direction = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -speed
	elif Input.is_action_pressed("down"):
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
			if attack_ip == false:
				animation.play("side_idle")
			
	if direction == "left" :
		animation.flip_h = true
		if move == 1:
			animation.play("side_walk")
		elif move == 0:
			if attack_ip ==  false:
				animation.play("side_idle")
			
	if direction == "up":
		if move == 1:
			animation.play("back_walk")
		elif move == 0:
			if attack_ip == false:
				animation.play("back_idle")
			
	if direction == "down":
		if move == 1:
			animation.play("front_walk")
		elif move == 0 :
			if attack_ip == false:
				animation.play("front_idle")


func _on_player_hit_box_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = true



func _on_player_hit_box_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = false
		
		
func player():
	pass
	
func ememy_attack()	:
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false 
		$attack_cooldown.start()
		print(health)

func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true
	
	
func attack():
	var dir = current_direction  
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true 
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
			
			
			


func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
	
