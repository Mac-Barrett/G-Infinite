extends Control

func _ready():
    pass # Replace with function body.

func _on_Single_Player_pressed():
    # get_tree().change_scene("res://Scenes/Testing.tscn")
    get_tree().change_scene("res://Scenes/Levels/Testing.tscn")
    pass


func _on_Track_Builder_pressed():
    get_tree().change_scene("res://Scenes/Levels/TrackBuilder.tscn")
    pass

func _on_Options_pressed():
    var options = load("res://Scenes/Menus/Options.tscn").instance()
    get_tree().current_scene.add_child(options)
    pass


func _on_Credits_pressed():
    var credits = load("res://Scenes/Menus/Credits.tscn").instance()
    get_tree().current_scene.add_child(credits)
    pass


func _on_Close_Game_pressed():
    get_tree().quit();
    pass # Replace with function body.



