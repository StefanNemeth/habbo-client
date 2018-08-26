
package com.sulake.habbo.room
{
    import com.sulake.room.IRoomInstance;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.habbo.room.utils.TileHeightMap;
    import com.sulake.habbo.room.utils.LegacyWallGeometry;

    public interface IRoomCreator extends IRoomObjectCreator 
    {

        function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:XML):void;
        function getRoom(_arg_1:int, _arg_2:int):IRoomInstance;
        function disposeRoom(_arg_1:int, _arg_2:int):void;
        function RoomEngine(_arg_1:int, _arg_2:int):Boolean;
        function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:int):void;
        function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:String):void;
        function RoomEngine(_arg_1:int, _arg_2:int):IRoomObjectController;
        function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:TileHeightMap):void;
        function RoomEngine(_arg_1:int, _arg_2:int):TileHeightMap;
        function RoomEngine(_arg_1:int, _arg_2:int):LegacyWallGeometry;
        function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:String):Number;
        function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:String):String;
        function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:Boolean):void;

    }
}//package com.sulake.habbo.room

// IRoomObjectCreator = "_-0Nw" (String#4044, DoABC#2)
// RoomEngine = "_-0UL" (String#1485, DoABC#2)
// RoomEngine = "_-0Hd" (String#1444, DoABC#2)
// disposeRoom = "_-2ya" (String#904, DoABC#2)
// RoomEngine = "_-18W" (String#1625, DoABC#2)
// RoomEngine = "_-qZ" (String#8718, DoABC#2)
// RoomEngine = "_-36n" (String#7446, DoABC#2)
// RoomEngine = "_-0on" (String#4611, DoABC#2)
// getRoom = "_-1jg" (String#1750, DoABC#2)
// RoomEngine = "_-1HB" (String#5193, DoABC#2)
// RoomEngine = "_-tM" (String#8756, DoABC#2)
// RoomEngine = "_-1tf" (String#1777, DoABC#2)
// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// IRoomInstance = "_-1j8" (String#5739, DoABC#2)
// LegacyWallGeometry = "_-2Nh" (String#6515, DoABC#2)
// TileHeightMap = "_-0Bg" (String#3789, DoABC#2)
// RoomEngine = "_-1SM" (String#1690, DoABC#2)
// RoomEngine = "_-Ht" (String#2080, DoABC#2)


