
package com.sulake.habbo.room
{
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.utils.SelectedRoomObjectData;
    import com.sulake.core.communication.connection.IConnection;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.room.utils.LegacyWallGeometry;
    import com.sulake.habbo.room.utils.TileHeightMap;
    import com.sulake.room.object.IRoomObjectController;

    public interface IRoomEngineServices extends IRoomObjectCreator 
    {

        function get activeRoomId():int;
        function get activeRoomCategory():int;
        function getRoomObjectCategory(_arg_1:String):int;
        function getRoomObject(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):IRoomObject;
        function updateObjectRoomWindow(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean=true):void;
        function setObjectMoverIconSprite(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:String=null):void;
        function setObjectMoverIconSpriteVisible(_arg_1:Boolean):void;
        function removeObjectMoverIconSprite():void;
        function getSelectedObjectData(_arg_1:int, _arg_2:int):ISelectedRoomObjectData;
        function setSelectedObjectData(_arg_1:int, _arg_2:int, _arg_3:SelectedRoomObjectData):void;
        function setPlacedObjectData(_arg_1:int, _arg_2:int, _arg_3:SelectedRoomObjectData):void;
        function getPlacedObjectData(_arg_1:int, _arg_2:int):ISelectedRoomObjectData;
        function get connection():IConnection;
        function get events():IEventDispatcher;
        function getLegacyGeometry(_arg_1:int, _arg_2:int):LegacyWallGeometry;
        function getTileHeightMap(_arg_1:int, _arg_2:int):TileHeightMap;
        function getSelectionArrow(_arg_1:int, _arg_2:int):IRoomObjectController;
        function getTileCursor(_arg_1:int, _arg_2:int):IRoomObjectController;
        function getIsPlayingGame(_arg_1:int, _arg_2:int):Boolean;
        function requestRoomAdImage(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:String):void;
        function requestMouseCursor(_arg_1:String, _arg_2:int, _arg_3:String):void;
        function addFloorHole(_arg_1:int, _arg_2:int, _arg_3:int):void;
        function removeFloorHole(_arg_1:int, _arg_2:int, _arg_3:int):void;

    }
}//package com.sulake.habbo.room

// getSelectedObjectData = "_-2oq" (String#899, DoABC#2)
// IRoomObjectCreator = "_-0Nw" (String#4044, DoABC#2)
// IRoomEngineServices = "_-28G" (String#6208, DoABC#2)
// getRoomObjectCategory = "_-L3" (String#8103, DoABC#2)
// updateObjectRoomWindow = "_-LV" (String#8113, DoABC#2)
// setObjectMoverIconSprite = "_-gt" (String#8532, DoABC#2)
// setObjectMoverIconSpriteVisible = "_-2Wi" (String#6694, DoABC#2)
// removeObjectMoverIconSprite = "_-1t-" (String#5901, DoABC#2)
// setSelectedObjectData = "_-mH" (String#2183, DoABC#2)
// setPlacedObjectData = "_-2bg" (String#6788, DoABC#2)
// getPlacedObjectData = "_-0vv" (String#4766, DoABC#2)
// getLegacyGeometry = "_-0UL" (String#1485, DoABC#2)
// getTileHeightMap = "_-0Hd" (String#1444, DoABC#2)
// getSelectionArrow = "_-01q" (String#3599, DoABC#2)
// getTileCursor = "_-qa" (String#8719, DoABC#2)
// getIsPlayingGame = "_-xX" (String#8834, DoABC#2)
// requestRoomAdImage = "_-296" (String#6229, DoABC#2)
// requestMouseCursor = "_-11O" (String#4903, DoABC#2)
// ISelectedRoomObjectData = "_-J6" (String#8063, DoABC#2)
// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// SelectedRoomObjectData = "_-0MS" (String#4010, DoABC#2)
// LegacyWallGeometry = "_-2Nh" (String#6515, DoABC#2)
// TileHeightMap = "_-0Bg" (String#3789, DoABC#2)
// activeRoomId = "_-kJ" (String#2172, DoABC#2)
// activeRoomCategory = "_-1qo" (String#1770, DoABC#2)
// getRoomObject = "_-1qD" (String#866, DoABC#2)
// addFloorHole = "_-u-" (String#8766, DoABC#2)
// removeFloorHole = "_-1hN" (String#5693, DoABC#2)


