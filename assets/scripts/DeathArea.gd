# script: ground collision

extends Area2D
class_name Ground

func _ready():
	pass 


func _on_DeathArea_body_entered(body):
	if body is Bird:
		if body.has_method("die"):
			body.die()
