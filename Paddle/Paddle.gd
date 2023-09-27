extends CharacterBody2D

var target = Vector2.ZERO
var speed = 10.0
var width = 0
var width_default = 0
var decay = 0.02
var EFFECT = preload("res://Effects/explosion.tscn")


func _ready():
	width = $CollisionShape2D.get_shape().size.x
	width_default = width
	target = Vector2(Global.VP.x / 2, Global.VP.y - 80)

func _physics_process(_delta):
	target.x = clamp(target.x, width/2, Global.VP.x - width/2)
	position = target
	for c in $Powerups.get_children():
		c.payload()

func _input(event):
	if event is InputEventMouseMotion:
		target.x += event.relative.x

func hit(_ball):
	$paddleHit.play()
	var paddle = get_node_or_null("/root/Game/Paddle_Container/Paddle")
	var effect = EFFECT.instantiate()
	add_child(effect)
	effect.global_position = Vector2(paddle.position.x, paddle.position.y - 30)
	pass

func powerup(payload):
	for c in $Powerups.get_children():
		if c.type == payload.type:
			c.queue_free()
	$Powerups.call_deferred("add_child", payload)
	

