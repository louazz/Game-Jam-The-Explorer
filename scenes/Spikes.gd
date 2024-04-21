extends Area2D

signal lives

func _on_Spikes_body_entered(body):
	if body.name == "Player": 
		print('hit')
		emit_signal('lives')
		# Global.lives -= 1
		print(Global.lives)
		queue_free()
		if Global.lives == 0:
			body.queue_free()
			var timer = Timer.new()
			add_child(timer)
			timer.wait_time= 10.0
			timer.start()
			get_tree().change_scene("res://scenes/Restart.tscn")
		# $Player/AnimatedSprite.animate = "death"
		# body.queue_free()
		#print(lives)
		#lives += 1
		# Global.score = lives
		#if lives == 3:
		#	body.queue_free()
