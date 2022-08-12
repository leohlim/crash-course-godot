extends KinematicBody

# Minimum speed of obstacle (meters per second)
export var min_speed = 10

# Maximum speed of obstacle (meters per second)
export var max_speed = 18

# Emitted when the player jumps on the obstacle
signal squashed

var velocity = Vector3.ZERO

func _physics_process(delta):
	move_and_slide(velocity)
	
	
# Call this function from the main scene
func initialize(start_position, player_position):
	
	# Position the mob, turn it so it looks at the player
	look_at_from_position(start_position, player_position, Vector3.UP)
	
	# Rotate randomly so it doesn't move towards the player
	rotate_y(rand_range(-PI / 4, PI / 4))
	
	# Calculate a random speed
	var random_speed = rand_range(min_speed, max_speed)
	
	# Calculate forward velocity representing speed
	velocity = Vector3.FORWARD * random_speed
	
	# Rotate vector based on obstacle's rotation, and move obstacle if facing correctly
	velocity = velocity.rotated(Vector3.UP, rotation.y) 


#func _on_VisibilityNotifier_screen_exited():
	#queue_free() 

func squash():
	emit_signal("squashed")
	queue_free()
