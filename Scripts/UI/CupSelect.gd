extends Control


func _on_Cup_Btn_pressed(CupName : String):
    var NextScene = load("res://Scenes/Menus/RaceSelect.tscn").instance()
    NextScene.myInit(CupName)
    get_tree().current_scene.add_child(NextScene)
    pass


func _on_Back_pressed():
    get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")
    pass
