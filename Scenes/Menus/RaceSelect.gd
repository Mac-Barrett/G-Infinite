extends Control

func myInit(CupName : String):
    setBGColor(CupName)
    setTrackNames(CupName)
    pass

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

func setTrackNames(CupName : String):
    var path = "res://SavedData/Cups/" + CupName + "/"
    var btns : Array = [$RaceList/T1, $RaceList/T2, $RaceList/T3, $RaceList/T4, $RaceList/T5]
    pass
