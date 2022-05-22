extends KinematicBody

class_name Racer

# Physics variables
var velocity = Vector3.ZERO
var impulse = Vector3.ZERO
var speed = 0

var turnSpeed = 0.015
var acceleration = 0.05
var deceleration = -0.05
var brake = 0.3

const baseImpulseDecay = 1
const boostImpulseDecay = 0.5
var impulseDecay = 1


var MAX_SPEED = 40
var fps = 60

# Meta Variables
var currLap = 0
var totalLaps = 3

var numCheckpoints = 0
const cpOffset = 2

var health = 100
var isHealing : bool
var power = 100

# Called by parent while being created
func set_numCheckpoints(num):
    numCheckpoints = num
    set_checkpoints(false)
    pass

# SIGNALS ---------------------------------------------------------------------
# Called by the finish line when this body crosses it
func _on_finish_line_crossed():
    set_collision_layer_bit(1, false)
    set_collision_mask_bit(1, false)
    if currLap >= 3:
        print("BaseRacer _on_finish_line_crossed: RACE OVER")
    else:
        currLap += 1
        print("BaseRacer _on_finish_line_crossed: STILL RACING: " + String(currLap))
    set_checkpoints(true)
    pass


# Called by the checkpoint when this body crosses it, setting the collision off
func _on_checkpoint_crossed(cpID):
    print("BaseRacer _on_cp_crossed: " + String(cpID))
    set_collision_layer_bit(cpID + cpOffset, false)
    set_collision_mask_bit(cpID + cpOffset, false)
    
    # If all of the checkpoints crossed, turn on collision for starting line
    if all_checkpoints_passed():
        set_collision_layer_bit(1, true)
        set_collision_mask_bit(1, true)
    pass


# Returns false if not all of the collision layers dedicated to checkpoints
# have been set to false (meaning not all checkpoints have been crossed)
func all_checkpoints_passed():
    for x in range(cpOffset, numCheckpoints + cpOffset):
        if get_collision_layer_bit(x) == true:
            return false
    return true


# Resets checkpoints to being all on or off depending on value of 'setting'
func set_checkpoints(setting): 
    for x in range(cpOffset, numCheckpoints + cpOffset):
        set_collision_layer_bit(x, setting)
        set_collision_mask_bit(x, setting)
    pass


# Called by healing strips to turn healing on/off
func set_isHealing(value):
    isHealing = value
    pass


# Called by boost strips to change the impulse vector
func boost_impulse(boost : Vector3):
    impulse = boost
    impulseDecay = boostImpulseDecay
    pass
