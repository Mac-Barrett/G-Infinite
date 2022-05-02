extends RigidBody

onready var parent = get_parent()

func _on_Area_body_entered(body):
    parent.call("_finish_line_crossed")
    pass
