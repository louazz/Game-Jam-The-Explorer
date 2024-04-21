extends Node2D

func _ready():
	VisualServer.set_default_clear_color(Color.skyblue)


func _on_StartButton_pressed():
	Global.lives = 3
	get_tree().change_scene("res://scenes/World.tscn")
