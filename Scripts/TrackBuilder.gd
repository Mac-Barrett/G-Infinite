extends Control

var trackData = []
var trackSize = 6

onready var trackPieceSlot = load("res://Scenes/Menus/TrackBuilderTrackSlot.tscn")

onready var track = $TrackPanel/track
onready var fileBrowser = $FileDialogue
onready var lineEditTrackSize = $OptionsPanel/VSplit/OptionButtons/TrackSizeLineEdit


func _ready():
    for x in range(0, trackSize):
        trackData.append([])
        for y in range(0, trackSize):
            trackData[x].append(-1)

            var tpSlot = trackPieceSlot.instance()
            
            tpSlot.get_child(0).set_gridPos(Vector2(x, y))
            track.add_child(tpSlot)
    pass

# Called when one of the track piece slots is updated
func update_trackData(gridPos, textureID):
    trackData[gridPos.x][gridPos.y] = textureID
    pass


# Uses trackData array to load track builder array
func load_track():
    # Clear out the old grid
    while(track.get_child_count() > 0):
        track.remove_child(track.get_child(0))
        
    # Instantiate new grid
    for x in range(0, trackSize):
        for y in range(0, trackSize):
            var tpSlot = trackPieceSlot.instance()
            
            tpSlot.get_child(0).set_gridPos(Vector2(x, y))
            
            var data = load_texture_by_ID(trackData[x][y])
            tpSlot.get_child(0).set_texture_on_load(data)
            track.add_child(tpSlot)
    pass


# Copies Texture & data from associated node while loading a new track
func load_texture_by_ID(ID):
    var path : String = "OptionsPanel/VSplit/TrackPieces/" + String(ID)
    var nodeWithTexture = get_node(path)
    var data = {
        "texture" : nodeWithTexture.texture,
        "flip_h" : nodeWithTexture.flip_h,
        "flip_v" : nodeWithTexture.flip_v,
        "trackSize" : trackSize
       }
    return data

# -----------------------------------------------------------------------------
# Button GUI

# Pulls up fileBroswer w/ Save Window
func _on_SaveTrack_pressed():
    fileBrowser.mode = FileDialog.MODE_SAVE_FILE
    fileBrowser.show()
    pass


# Pulls up fileBroswer w/ Open Window
func _on_LoadTrack_pressed():
    fileBrowser.mode = FileDialog.MODE_OPEN_FILE
    fileBrowser.show()
    pass


# Calls clear_track
func _on_ClearTrack_pressed():
    clear_track()
    pass

# Destroys original array and allocates a new one based on trackSize
func clear_track():
    trackData.resize(trackSize)
    for x in range(0, trackSize):
        if (trackData[x] == null):
            trackData[x] = []
        trackData[x].resize(trackSize)
        for y in range(0, trackSize):
            trackData[x][y] = -1
    load_track()
    pass


# Instances Level Loader Scene w/ TrackData
func _on_TestTrack_pressed():
    var test = load("res://Scenes/LevelLoader.tscn").instance()
    test.set_trackData(trackData)
    get_tree().current_scene.add_child(test)
    visible = false
    pass


# Pressed on OK/OPEN For saving and opening files...
func _on_FileDialogue_confirmed():
    # SAVE FILE
    if (fileBrowser.mode == FileDialog.MODE_SAVE_FILE):
        print("SAVING FILE...")
        var theFile : String = fileBrowser.current_path
        var f = File.new()
        f.open(theFile, File.WRITE)
        var saveData = {
            "trackName" : "TEST",
            "trackSize" : trackSize,
            "trackData" : trackData
           }
        f.store_var(JSON.print(saveData))
        f.close()
    # LOAD FILE
    elif (fileBrowser.mode == FileDialog.MODE_OPEN_FILE):
        print("OPENING FILE...")
        var theFile : String = fileBrowser.current_path
        var f = File.new()
        f.open(theFile, File.READ)
        var text_file_data = f.get_as_text()
        f.close()
        
        # Parse JSON
        var parsed_file_data = JSON.parse(text_file_data)
        var result = parsed_file_data.result
        trackData = result["trackData"].duplicate()
        trackSize = result["trackSize"]
        
        # Convert to int array for some reason
        for x in range(0, trackSize):
            for y in range(0, trackSize):
                trackData[x][y] = int(trackData[x][y])
        track.columns = trackSize
        lineEditTrackSize.text = String(trackSize)
        load_track()
    pass


func _on_LineEdit_text_entered(new_text):
    if (int(new_text) >= 10 or int(new_text) <= 3):
        lineEditTrackSize.text = String(trackSize)
    else:
        trackSize = int(lineEditTrackSize.text)
    track.columns = trackSize
    _on_ClearTrack_pressed()
    pass
