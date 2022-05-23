extends Control

func _ready():
    pass # Replace with function body.

# Starts the Cup Select Scene
func _on_Single_Player_pressed():
    get_tree().change_scene("res://Scenes/Menus/CupSelect.tscn")
    # get_tree().current_scene.add_child(CupSelect)
    pass

# Starts the Track Builder Scene
func _on_Track_Builder_pressed():
    get_tree().change_scene("res://Scenes/Levels/TrackBuilder.tscn")
    #var TrackBuilder = load("res://Scenes/Levels/TrackBuilder.tscn").instance()
    #get_tree().current_scene.add_child(TrackBuilder)
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



