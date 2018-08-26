
package com.sulake.room
{
    import com.sulake.room.object.IRoomObject;

    public interface IRoomInstanceContainer 
    {

        function createRoomObject(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:int):IRoomObject;
        function createRoomObjectManager():IRoomObjectManager;

    }
}//package com.sulake.room

// createRoomObject = "_-20d" (String#1799, DoABC#2)
// createRoomObjectManager = "_-1Ry" (String#1688, DoABC#2)
// IRoomObjectManager = "_-iT" (String#8568, DoABC#2)


