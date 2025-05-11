using { /Verse.org/Simulation }

PlayerPersistence<public> := module:
    (Player: player).Save<public>(Key: string, Value: string)<transacts><decides>: void =
        Player.IsActive[]
        var NewDataMap: [string]string = PlayerPersistenceMap[Player].DataMap or map{}
        set NewDataMap[Key] = Value
        set PlayerPersistenceMap[Player] = persistent_player_data { DataMap := NewDataMap }

    (Player: player).GetSaved<public>(Key: string)<transacts><decides>: string =
        Player.IsActive[]
        return PlayerPersistenceMap[Player].DataMap[Key]

    var PlayerPersistenceMap: weak_map(player, persistent_player_data) = map{}

    persistent_player_data := class<final><persistable>:
        DataMap: [string]string = map{}