extends Control


func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	var parent = get_parent();
	parent.remove_child(parent.get_child(1));
	pass # Replace with function body.
