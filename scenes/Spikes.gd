extends Area2D

var lives = 0

func _on_Spikes_body_entered(body):
	if body.name == "KinematicBody2D": 
		#$AnimatedSprite.animate = "death"
		# await get_tree().create_timer(5).timeout
		#body.queue_free()
		print(lives)
		lives += 1
		if lives == 3:
			body.queue_free()
