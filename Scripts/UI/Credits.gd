extends Control


func _ready():
    pass # Replace with function body.


func _on_Button_pressed():
    var parent = get_parent();
    parent.remove_child(get_node(self.get_path()));
    pass # Replace with function body.
