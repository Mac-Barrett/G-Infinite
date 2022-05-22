extends "res://Scripts/BaseRacer.gd"

# HUD elements
onready var DEBUG = get_node("HUD/Debug")
onready var lapCounterLabel = get_node("HUD/TopRightBox/LapCounter")
onready var powerSlider = get_node("HUD/TopRghtBox/VBoxTopRight/Power")
onready var healthSlider = get_node("HUD/TopRightBox/VBoxTopRight/Health")
onready var speedLabel = get_node("HUD/SpeedBox/Speed")
onready var speedSlider = get_node("HUD/SpeedBox/SpeedSlider")

# On Ready
func _ready():
    move_lock_y = true
    pass

# PHYSICS ---------------------------------------------------------------------
# On Tick Function
func _physics_process(delta):
    get_input()
    set_camera()
    update_HUD()
    if isHealing:
        health = min(100, health + (5 * (2.0 / 60)))
    handle_(move_and_collide(velocity * delta))
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
        $Camera.rotation_degrees.z = lerp($Camera.rotation_degrees.z, 0, 0.1)
    else:
        if Input.is_key_pressed(KEY_D):
            turn(true)
        if Input.is_key_pressed(KEY_A):
            turn(false)
        
    velocity -= transform.basis.x * speed
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


# sets rotation of vehicle
func turn(turnRight):
    if (turnRight == true):
        rotate_y(-turnSpeed)
        rotation_degrees.x = lerp(rotation_degrees.x, -10, 0.1)
        $Camera.rotation_degrees.z = lerp($Camera.rotation_degrees.z, 9, 0.1)
    else:
        rotate_y(turnSpeed)
        rotation_degrees.x = lerp(rotation_degrees.x, 10, 0.1)
        $Camera.rotation_degrees.z = lerp($Camera.rotation_degrees.z, -9, 0.1)
    pass


# sets camera position based on speed
func set_camera():
    $Camera.translation.x = 3 + (speed / 50)
    $Camera.rotation_degrees.x = -30 + (speed / 6)
    pass


# handles collisions from move_and_collide()
func handle_(collision):
    if (collision != null):
        impulseDecay = baseImpulseDecay
        
        var hitMagnitude = (abs(speed) / 6) * 10
        hitMagnitude *= angle_multiplyer(collision)
        
        speed = max(1, speed - 10)
        impulse.x = collision.normal.x * hitMagnitude
        impulse.z = collision.normal.z * hitMagnitude
        
        health = health - int(hitMagnitude * 0.1)
        
        $HUD/Debug/CollisionMagnitude.text = "Hit Magnitude: " + String(hitMagnitude)
        $HUD/Debug/CollisionNormal.text = "Collision Normal: " + String(collision.normal)
        
        collision = null
    pass


# Uses collision normal and player's direction to calculate
# a multiplyer for the hitMagnitude
func angle_multiplyer(collision):
    var angleMultiplyer
    if (collision.normal.x == 1 or collision.normal.x == -1):
        angleMultiplyer = abs(transform.basis.x.x)
    elif (collision.normal.z == 1 or collision.normal.z == -1):
        angleMultiplyer = abs(transform.basis.x.z)
    else:
        # Some error so set it to a middle ground
        angleMultiplyer = 0.5
    return (angleMultiplyer + 0.5)
    

# HUD & GUI -------------------------------------------------------------------
# updates debug HUD elements
func update_Debug():
    DEBUG.get_child(0).text = "Speed: " + String(speed)
    var hypotenusLV = sqrt((velocity.x * velocity.x) + (velocity.z * velocity.z))
    DEBUG.get_child(1).text = "LinearVelocity: " + String(hypotenusLV)
    DEBUG.get_child(2).text = "Direction: " + String(transform.basis.x)
    

    pass


# updates HUD elements
func update_HUD():
    update_Debug()
    lapCounterLabel.text = "Lap " + String(currLap) + "/" + String(totalLaps)
    #powerSlider.value = 100
    healthSlider.value = health
    
    var hypotenusLV = sqrt((velocity.x * velocity.x) + (velocity.z * velocity.z))
    speedLabel.text = String(int(hypotenusLV) * 26) + " kmh"
    speedSlider.value = (speed / MAX_SPEED) * 100
    pass
