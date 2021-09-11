extends Node2D


func _ready():
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			$texto/anim_texto.play("animar_texto")
			yield($texto/anim_texto, "animation_finished")
			$color/anim_color.play("animar_color")
			yield($color/anim_color, "animation_finished")
			get_tree().change_scene("res://scenes/fase01.tscn")
