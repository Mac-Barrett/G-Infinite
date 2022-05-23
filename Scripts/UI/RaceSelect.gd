extends Control

func myInit(CupName : String):
    print("Initializing Track Files/Btns: " + CupName)
    var btns : Array = [$RaceList/T1, $RaceList/T2, $RaceList/T3, $RaceList/T4, $RaceList/T5]
    var path : String = "res://SavedData/Cups/" + CupName
    
    setBGColor(CupName)
    setTrackNames(path, btns)
    setBtnBindings(path, btns)
    pass

# Sets a BG Color based on the Cup you're selecting from
func setBGColor(CupName : String):
    var BG : ColorRect = $Background
    match(CupName):
        "Bronze":
            BG.color = "#e67300"
        "Silver":
            BG.color = "#f2f2f2"
        "Gold":
            BG.color = "#ffd633"
        "Platinum":
            BG.color = "#666699"
        "Diamond":
            BG.color = "#99ffff"
    pass

# Loads the track names from the corresponding directory
func setTrackNames(path : String, btns : Array):
    var dir = Directory.new()
    
    dir.change_dir(path)
    if dir.open(path) == OK:
        dir.list_dir_begin(true)
        var fileName = dir.get_next()
        var i = 0
        while fileName != "":
            btns[i].text = fileName
            fileName = dir.get_next()
            i += 1
    pass

# Connects btns to the event listener & binds the fileName to be loaded
func setBtnBindings(path : String, btns : Array):
    for i in range(0, btns.size()):
        btns[i].connect("pressed", self, "_on_Track_Btn_pressed", [path, btns[i].text])
    pass

# Button handling loading the logic for loading a level
func _on_Track_Btn_pressed(path : String, fileName : String):
    var trackPath : String = path + "/" + fileName
    print(trackPath)
    var trackLoad = ResourceLoader.load(trackPath)
    if trackLoad is TrackSave:
        var trackData = trackLoad.trackData.duplicate()
        var LL = load("res://Scenes/Levels/LevelLoader.tscn").instance()
        LL.set_trackData(trackData)
        get_tree().current_scene.add_child(LL)
        get_parent().visible = false
        visible = false
    pass


func _on_Back_pressed():
    var parent = get_parent();
    parent.remove_child(get_node(self.get_path()));
    pass
