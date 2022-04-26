extends KinematicBody

onready var HUD = get_node("HUD/Debug")
onready var hitbox = get_node("CollisionShape")
onready var body = get_node("Model")
onready var camera = get_node("Camera")

var velocity = Vector3.ZERO
var impulse = Vector3.ZERO
var speed = 0

var turnSpeed = 0.015
var acceleration = 0.05
var deceleration = -0.05
var impulseDecay = 1
var brake = 0.3

var MAX_SPEED = 40
var fps = 60


# On Ready
func _ready():
	move_lock_y = true
	pass


# reads user input
func get_input():
	velocity = impulse
	decay_impulse()
	
	var accelerating = false
	if Input.is_key_pressed(KEY_W):
		speed = min(speed + acceleration * (MAX_SPEED / (speed + 5)), MAX_SPEED)
		accelerating = true
	elif speed > 0:
		speed += deceleration
		
	if Input.is_key_pressed(KEY_S):
		speed = max(speed - brake, -4.9)
	elif not accelerating && speed < 0:
		speed -= deceleration

	if not (Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_A)):
		rotation_degrees.x = lerp(rotation_degrees.x, 0, 0.1)
		camera.rotation_degrees.z = lerp(camera.rotation_degrees.z, 0, 0.1)
	else:
		if Input.is_key_pressed(KEY_D):
			turn(true)
		if Input.is_key_pressed(KEY_A):
			turn(false)
		
	velocity -= transform.basis.x * speed
	HUD.get_child(0).text = "Speed: " + String(speed)
	HUD.get_child(1).text = "Velocity: " + String(transform.basis.x)
	pass


# sets rotation of vehicle
func turn(turnRight):
	if (turnRight == true):
		rotate_y(-turnSpeed)
		rotation_degrees.x = lerp(rotation_degrees.x, -10, 0.1)
		camera.rotation_degrees.z = lerp(camera.rotation_degrees.z, 9, 0.1)
	else:
		rotate_y(turnSpeed)
		rotation_degrees.x = lerp(rotation_degrees.x, 10, 0.1)
		camera.rotation_degrees.z = lerp(camera.rotation_degrees.z, -9, 0.1)
	pass


# updates HUD elements
func update_HUD():
	HUD.get_child(0).text = "Speed: " + String(speed)
	HUD.get_child(1).text = "Velocity: " + String(transform.basis.x)
	pass


# sets camera position based on speed
func set_camera():
	camera.translation.x = 3 + (speed / 50)
	camera.rotation_degrees.x = -30 + (speed / 6)
	pass


# handles collisions
func handle_(collision):
	if (collision != null):
		var hitMagnitude = (abs(speed) / 5) * 10
		speed = max(1, speed - 10)
		impulse.x = collision.normal.x * hitMagnitude
		impulse.z = collision.normal.z * hitMagnitude
		collision = null
	pass


# decays the impulse vector from collisions
func decay_impulse():
	if (impulse.x > 0.5):
		impulse.x -= impulseDecay
	elif (impulse.x < -0.5):
		impulse.x += impulseDecay
	else:
		impulse.x = 0
		
	if (impulse.z > 0.5):
		impulse.z -= impulseDecay
	elif (impulse.z < -0.5):
		impulse.z += impulseDecay
	else:
		impulse.z = 0
	pass


# On Tick Function
func _physics_process(delta):
	get_input()
	set_camera()
	update_HUD()
	handle_(move_and_collide(velocity * delta))
	pass
