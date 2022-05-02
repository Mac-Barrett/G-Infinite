extends Control

var trackData = []
var trackSize = 6

onready var track = get_node("TrackPanel/track")
onready var trackPieceSlot = load("res://Scenes/Menus/TrackBuilderTrackSlot.tscn")
onready var fileBrowser = get_node("FileDialogue")


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
        "flip_v" : nodeWithTexture.flip_v
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


# Clears trackData array and the viewport
func _on_ClearTrack_pressed():
    for x in range(0, trackSize):
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
        
        # Convert to int array for some reason
        for x in range(0, trackSize):
            for y in range(0, trackSize):
                trackData[x][y] = int(trackData[x][y])
        load_track()
    pass
