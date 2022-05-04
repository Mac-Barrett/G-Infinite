extends RigidBody

signal finish_line_crossed

func _on_Area_body_entered(body):
    if body.is_in_group("Racer"):
        emit_signal("finish_line_crossed")
        print_debug("StartBlock: Crossed")
    pass
