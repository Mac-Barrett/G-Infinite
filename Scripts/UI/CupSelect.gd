extends Control


func _on_Back_pressed():
    var parent = get_parent();
    parent.remove_child(get_node(self.get_path()));
    pass


func _on_Cup_Btn_pressed(CupName : String):
    print(CupName)
    var NextScene = load("res://Scenes/Menus/RaceSelect.gd").intance()
    NextScene.myInit(CupName)
    pass
