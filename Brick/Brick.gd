extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false
var time_appear = 0.5
var time_fall = 0.8
var time_rotate = 1.0
var time_a = 0.5
var time_s = 1.0
var time_v = 1.0
var tween

var powerup_prob = 80

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	position.x = new_position.x
	position.y = -100
	tween = create_tween()
	tween.tween_property(self, "position", new_position, 0.5 + randf()*2).set_trans(Tween.TRANS_BOUNCE)

func _physics_process(_delta):
	if dying and not $Water.emitting:
		queue_free()

func hit(_ball):
	die()

func die():
	dying = true
	$CollisionShape2D.queue_free()
	Global.update_score(score)
	get_parent().check_level()
	$Water.emitting = true
	if tween:
		tween.kill()
	tween = create_tween().set_parallel(true)
	tween.tween_property(self, "position", Vector2(position.x, 1000), time_fall).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "rotation", -PI + randf()*2*PI, time_rotate).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	#dying = true
	#$CollisionShape2D.queue_free()
	#Global.update_score(score)
	#get_parent().check_level()
	#$Water.emitting = true
	#if tween:
#		tween.kill()
	#tween = create_tween().set_parallel(true)
	#tween.tween_property(self, "position", Vector2(position.x, 1000), time_fall).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	#tween.tween_property(self, "rotation", -PI + randf()*2*PI, time_rotate).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instantiate()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)

#func die():
#	dying = true
#	$CollisionShape2D.queue_free()
#	Global.update_score(score)
#	get_parent().check_level()
#	$Water.emitting = true
#	if tween:
#		tween.kill()
#	tween = create_tween().set_parallel(true)
#	tween.tween_property(self, "position", Vector2(position.x, 1000), time_fall).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
#	tween.tween_property(self, "rotation", -PI + randf()*2*PI, time_rotate).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
