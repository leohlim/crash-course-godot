extends Node

export (PackedScene) var obstacle_scene

func _ready():
	randomize()


func _on_ObstacleTimer_timeout():
	
	# Create new instance of the obstacle
	var obstacle = obstacle_scene.instance()
	
	# Choose random location on Spawn Path
	# Store the reference to the Spawn Location node
	var obstacle_spawn_location = get_node("SpawnPath/SpawnLocation")
	
	# Give it a random offset
	obstacle_spawn_location.unit_offset = randf()
	
	var player_position = $Player.transform.origin
	obstacle.initialize(obstacle_spawn_location.translation, player_position)
	
	add_child(obstacle)
