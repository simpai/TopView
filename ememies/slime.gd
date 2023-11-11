extends CharacterBody2D

@export var speed : int = 20
@export var limit = 0.5
@export var endPoint : Marker2D

@onready var animations = $AnimationPlayer

var isDead : bool = false
var startPosition
var endPosition

func _ready():
	isDead = false
	
	startPosition = position
	endPosition = endPoint.global_position

func changeDirection():
	var temp = startPosition
	startPosition = endPosition
	endPosition = temp 

func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit :
		changeDirection()
			
	velocity = moveDirection.normalized() * speed
	
	
func updateAnimation():
	if velocity == Vector2.ZERO:
		animations.stop()
	else:
		var dir = "Down"
		
		if velocity.x < 0:
			dir = "Left"
		elif velocity.x > 0:
			dir = "Right" 
		elif velocity.y < 0:
			dir = "Up"
		else :    
			dir = "Down"
		
		animations.play("walk" + dir)
	
	
func _physics_process(delta):
	if isDead: return
	
	updateVelocity()
	updateAnimation()
	move_and_slide()

func collect():
	queue_free()



func _on_hurt_bux_area_entered(area):
	if area == $hitBox : return
	$hitBox.set_deferred("monitorable", false)
	animations.play("death")
	isDead = true
	await animations.animation_finished
	queue_free()
