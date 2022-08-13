extends KinematicBody

# How fast the player moves in meters per second
export var speed = 12 

# Downward acceleration when in the air, in meters per second squared
export var fall_acceleration = 75

export var jump_impulse = 30

export var bounce_impulse = 16

var velocity = Vector3.ZERO


func _physics_process(delta):
	# We create a local variable to store the input direction
	var direction = Vector3.ZERO
	
	# We check for each move input and update direction accordingly
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		
	if direction != Vector3.ZERO: 
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)
	
	# Ground velocity
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	# Vertical velocity
	velocity.y -= fall_acceleration * delta
	
	# Jump
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
		
	# Moving the character
	velocity = move_and_slide(velocity, Vector3.UP)
	
	for index in range (get_slide_count()):
		# Check every collision that occured this frame.
		var collision = get_slide_collision(index)
		
		# If we collide with an obstacle...
		if collision.collider.is_in_group("obstacle"):
			var obstacle = collision.collider
			
			# Check that we are hitting it from above
			if Vector3.UP.dot(collision.normal) > 0.1:
				
				# If so, we bounce on it and kill it
				obstacle.squash()
				velocity.y = bounce_impulse
	
	
	
