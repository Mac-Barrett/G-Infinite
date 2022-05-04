extends RigidBody

var checkpointID
const cpOffset = 2

signal checkpoint_crossed

func set_checkpointID(cpID):
    checkpointID = cpID
    $Area.set_collision_layer_bit(checkpointID + cpOffset, true)
    $Area.set_collision_mask_bit(checkpointID + cpOffset, true)
    pass

func _on_Area_body_entered(body):
    if body.is_in_group("Racer"):
        emit_signal("checkpoint_crossed", checkpointID)
        print_debug("Checkpoint " + String(checkpointID) + ": Crossed")
    pass
