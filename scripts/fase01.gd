extends Node2D


func _ready():
	pass


func _on_alavanca_body_entered(body):
	if body.name == "player":
		$alavanca/alavanca/anim.play("alavanca")
