extends CharacterBody2D

signal healthChanged

@export var speed : int = 35
@onready var animations = $AnimationPlayer
@onready var effects = $effects
@onready var hurt_box = $hurtBox
@onready var weapon = $weapon

@export var maxHealth : int = 3
@onready var currentHealth : int = maxHealth

@export var knockbackPower = 1000
@onready var hurt_timer = $hurtTimer

@export var inventory : Inventory

var isHurt : bool = false
var lastDir : String = "Down"
var isAttacking : bool = false

func _ready():
	weapon.disable()

func handleInput():
	var moveDirction = Input.get_vector("left", "right", "up", "down")
	velocity = moveDirction * speed

	if Input.is_action_just_pressed("attack"):
		attack()

func attack():
	weapon.enable()
	isAttacking = true
	animations.play("attack" + lastDir)
	await animations.animation_finished
	weapon.disable()
	isAttacking = false
	animations.play("walk" + lastDir)


func updateAnimation():
	if isAttacking == true:
		return
		
	if velocity == Vector2.ZERO:
		animations.stop()
	else:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x < 0:
				lastDir = "Left"
			elif velocity.x > 0:
				lastDir = "Right" 			
		else:
			if velocity.y < 0: 
				lastDir = "Up"
			elif velocity.y > 0:
				lastDir = "Down"
		animations.play("walk" + lastDir)

		

func _physics_process(delta):
	handleInput() 		#input을 이용해서 velocity를 정하고
	move_and_slide() 	#velocity를 이용해서 이동
	updateAnimation()

	for area in hurt_box.get_overlapping_areas():
		if isHurt == false:
			if area.name == "hitBox":
				hurtByEnemy(area)


func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)

func _on_hurt_box_area_exited(area):
	pass
#	collidedEnemyList.erase(area)

func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
		
	healthChanged.emit(currentHealth)
	knockback(area.get_parent().velocity)
	
	isHurt = true
	effects.play("hurtBlink")
	hurt_timer.start()
	await hurt_timer.timeout
	effects.play("RESET")
	isHurt = false

func knockback(enemyVelocity: Vector2):
	var dir = (enemyVelocity-velocity).normalized() * knockbackPower
	velocity = dir
	move_and_slide()


