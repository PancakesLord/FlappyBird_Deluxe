#script: obstacle_spawner

extends Node2D

onready var timer = $Timer
onready var scn_obstancle = preload("res://subscenes/obstacle.tscn")

onready var rng = RandomNumberGenerator.new()

signal obstacle_created(obs)

func _ready():
	pass


func spawn_obstacle():
	var obstacle = scn_obstancle.instance()
	add_child(obstacle)
	obstacle.position.y = rng.randi_range(200, 400)
	emit_signal("obstacle_created", obstacle)


func _on_Timer_timeout():
	spawn_obstacle()


func start():
	timer.start()


func stop():
	timer.stop()

