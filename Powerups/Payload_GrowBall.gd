#extends Node2D

#var type = "grow_ball"
#
#func _ready():
#	$Timer.start()
#	var Ball_Container = get_node_or_null("/root/Game/Ball_Container")
#	if Ball_Container != null:
#		for c in Ball_Container.get_children():			
#			c.call_deferred("change_size", Vector2(2,2))
#
#func payload():
#	pass
#
#func _on_Timer_timeout():
#	print("timeout")
#	var Ball_Container = get_node_or_null("/root/Game/Ball_Container")
#	if Ball_Container != null:
#		for c in Ball_Container.get_children():
#			c.call_deferred("change_size", Vector2(1,1))
#	queue_free()
#

extends Node2D

var type = "grow_ball"

func _ready():
	$Timer.start()
	var ball = find_parent("Ball")
	if ball != null:
		ball.call_deferred("set_scale", Vector2(2,2))
		ball.width = ball.width_default * 2

func payload():
	pass
	
func _on_Timer_timeout():
	var ball = find_parent("Ball")
	if ball != null:
		ball.call_deferred("set_scale", Vector2(1,1))
		ball.width = ball.width_default
	queue_free()
