extends Node2D


func _ready():
	VisualServer.set_default_clear_color(Color.skyblue)
	$CanvasLayer/lives.text = "Lives: "+ str(Global.lives)
	for spike in $TileMap.get_children():
		spike.connect("lives", self, "_on_Spikes_lives")


func _on_Spikes_lives():
	Global.lives -= 1
	Global.decayed = true
	$CanvasLayer/lives.text = "Lives: "+ str(Global.lives)
