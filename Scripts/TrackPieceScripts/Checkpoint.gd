extends RigidBody

var checkpointID
const cpOffset = 2

func set_checkpointID(cpID):
    checkpointID = cpID
    $Area.set_collision_layer_bit(checkpointID + cpOffset, true)
    $Area.set_collision_mask_bit(checkpointID + cpOffset, true)
    pass

func _on_Area_body_entered(body):
    if body.is_in_group("Racer"):
        var castedRacer : Racer = body
        castedRacer._on_checkpoint_crossed(checkpointID)
    pass
