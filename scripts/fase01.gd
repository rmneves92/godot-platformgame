extends Node2D


func _ready():
	pass


func _on_alavanca_body_entered(body):
	if body.name == "player":
		$alavanca/alavanca/anim.play("alavanca")
		yield($alavanca/alavanca/anim, "animation_finished")
		get_tree().call_group("plat", "ligar")

		
