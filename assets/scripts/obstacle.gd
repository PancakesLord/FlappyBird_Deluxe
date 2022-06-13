# script: obstacle

extends Node2D

onready var rng = RandomNumberGenerator.new()
onready var bird = Bird.new()

const SPEED = -150

signal score

func _ready():
	add_to_group("Obstacles")
	randomize_pos()
	set_physics_process(true)
	bird.connect("died", self, "_on_Bird_died")


func _physics_process(delta):
	position.x += SPEED * delta

	if position.x <= -300:
		queue_free()


func randomize_pos():
	global_position.y = rng.randi_range(180, 420)


func _on_PipeTop_body_entered(body):
	if body is Bird:
		if body.has_method("die"):
			body.die()


func _on_PipeBottom_body_entered(body):
	if body is Bird:
		if body.has_method("die"):
			body.die()


func _on_ScoreArea_body_shape_entered(body_id, body, body_shape, area_shape):
	if body is Bird:
		emit_signal("score")



