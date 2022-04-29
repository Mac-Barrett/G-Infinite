extends Control

var trackData = []
var trackSize = 6

onready var track = get_node("TrackPanel/track")
onready var trackPieceSlot = load("res://Scenes/Menus/TrackBuilderTrackSlot.tscn")


func _ready():
    for x in range(0, trackSize):
        trackData.append([])
        for y in range(0, trackSize):
            trackData[x].append(-1)

            var tpSlot = trackPieceSlot.instance()
            
            tpSlot.get_child(0).set_gridPos(Vector2(x, y))
            track.add_child(tpSlot)
    pass
    
func update_trackData(gridPos, textureID):
    trackData[gridPos.x][gridPos.y] = textureID
    pass


# ---------------------------
# Button GUI
func _on_SaveTrack_pressed():
    var f = File.new()
    f.open("res://SavedData/Tracks/0.txt", File.WRITE)
    var saveData = {
        "trackName" : "TEST",
        "trackData" : trackData
       }
    f.store_var(JSON.print(saveData))
    f.close()
    pass


func _on_LoadTrack_pressed():
    pass


func _on_ClearTrack_pressed():
    pass


func _on_TestTrack_pressed():
    var test = load("res://Scenes/LevelLoader.tscn").instance()
    test.set_trackData(trackData)
    get_tree().current_scene.add_child(test)
    visible = false
    pass
