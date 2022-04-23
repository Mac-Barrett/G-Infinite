extends KinematicBody

var velocity = Vector3.ZERO
var impulse = Vector3.ZERO
var speed = 0

var turnSpeed = 0.015
var acceleration = 0.1
var deceleration = -0.05
var brake = 0.3

var MAX_SPEED = 40
var fps = 60

onready var HUD = get_node("HUD/Debug")
onready var hitbox = get_node("CollisionShape")
onready var body = get_node("Model")
onready var camera = get_node("Camera")

func _ready():
	move_lock_y = true
	pass
	
func decay_impulse():
	if (impulse.x > 0):
		impulse.x += deceleration
	if (impulse.z > 0):
		impulse.z += deceleration
	pass

func get_input():
	velocity = impulse
	decay_impulse()
	
	var accelerating = false
	if Input.is_key_pressed(KEY_W):
		speed = min(speed + acceleration, MAX_SPEED)
		accelerating = true
	elif speed > 0:
		speed += deceleration
		
	if Input.is_key_pressed(KEY_S):
		speed = max(speed - brake, -5)
	elif not accelerating && speed < 0:
		speed -= deceleration

	if not (Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_A)):
		rotation_degrees.x = lerp(rotation_degrees.x, 0, 0.1)
		camera.rotation_degrees.z = lerp(camera.rotation_degrees.z, 0, 0.1)
	else:
		if Input.is_key_pressed(KEY_D):
			rotate_y(-turnSpeed)
			rotation_degrees.x = lerp(rotation_degrees.x, -10, 0.1)
			camera.rotation_degrees.z = lerp(camera.rotation_degrees.z, 9, 0.1)
		if Input.is_key_pressed(KEY_A):
			rotate_y(turnSpeed)
			rotation_degrees.x = lerp(rotation_degrees.x, 10, 0.1)
			camera.rotation_degrees.z = lerp(camera.rotation_degrees.z, -9, 0.1)
		
	velocity -= transform.basis.x * speed
	HUD.get_child(0).text = "Speed: " + String(speed)
	HUD.get_child(1).text = "Velocity: " + String(transform.basis.x)
	

func set_camera():
	camera.translation.x = 3 + (speed / 50)
	camera.rotation_degrees.x = -30 + (speed / 6)
	
	pass

func _physics_process(delta):
	get_input()
	set_camera()
	velocity = move_and_slide(velocity, Vector3())
	pass


func _on_Area_body_entered(body):
	
	speed = max(5, speed - 5)
	impulse = Vector3(0,0,10)
	
	pass # Replace with function body.
