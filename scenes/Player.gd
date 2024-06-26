extends KinematicBody2D
export(int) var JUMP_FORCE = 130
export(int) var JUMP_RELEASE_FORCE = -70
export(int) var GRAVITY = 4
export(int) var ACCELERATION = 10
export(int) var FRICTION =10
export(int) var MAX_SPEED = 50

var velocity= Vector2.ZERO
var jump = 0

func _physics_process(delta):
	apply_gravity()
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input.x == 0:
		apply_friction()
		$AnimatedSprite.animation = "idle"
	else:
		apply_acceleration(input.x)
		if Global.decayed == true :
			$AnimatedSprite.animation = "damage"
			yield(get_tree().create_timer(0.5), "timeout")
			# OS.delay_msec(1000)
			# $AnimatedSprite.animation = "run"
			Global.decayed = false
		else:
			$AnimatedSprite.animation = "run"
		if input.x > 0:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("ui_left"):
		velocity.x = -200
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 200
	else: 
		velocity.x = 0
	
	if is_on_floor():
		jump = 0
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -JUMP_FORCE
			print(velocity.y)
	else:
		if Input.is_action_just_pressed("ui_up"):
			jump +=1
			if jump < 2:
				velocity.y = -JUMP_FORCE
			# print(velocity.y)
		if Global.lives <3:
			$AnimatedSprite.animation = "decayed_jump"
		else:
			$AnimatedSprite.animation = "jump"
		var fast_fell = false
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELEASE_FORCE:
			velocity.y = JUMP_RELEASE_FORCE
		if velocity.y > 10 and not fast_fell:
			velocity.y +=25
			fast_fell = true
			
	velocity=move_and_slide(velocity, Vector2.UP)

func apply_gravity():
	velocity.y += GRAVITY
	velocity.y = min(velocity.y, 300)
	
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, ACCELERATION)
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, 20)
	
