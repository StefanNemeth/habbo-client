
package com.sulake.room
{
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.renderer.IRoomRendererBase;

    public interface IRoomInstance 
    {

        function getNumber(_arg_1:String):Number;
        function setNumber(_arg_1:String, _arg_2:Number, _arg_3:Boolean=false):void;
        function getString(_arg_1:String):String;
        function setString(_arg_1:String, _arg_2:String, _arg_3:Boolean=false):void;
        function dispose():void;
        function update():void;
        function createRoomObject(_arg_1:int, _arg_2:String, _arg_3:int):IRoomObject;
        function RoomInstance(_arg_1:int, _arg_2:int):IRoomObject;
        function RoomInstance(_arg_1:int, _arg_2:int):Boolean;
        function RoomInstance(_arg_1:int):int;
        function RoomInstance(_arg_1:int, _arg_2:String, _arg_3:int):IRoomObject;
        function RoomInstance(_arg_1:String, _arg_2:int):int;
        function RoomInstance(_arg_1:int, _arg_2:int):IRoomObject;
        function RoomInstance(_arg_1:int):int;
        function RoomInstance(_arg_1:IRoomRendererBase):void;
        function RoomInstance():IRoomRendererBase;

    }
}//package com.sulake.room

// RoomInstance = "_-05z" (String#3684, DoABC#2)
// createRoomObject = "_-20d" (String#1799, DoABC#2)
// RoomInstance = "_-1zT" (String#6024, DoABC#2)
// RoomInstance = "_-252" (String#1807, DoABC#2)
// RoomInstance = "_-3E-" (String#921, DoABC#2)
// RoomInstance = "_-2T0" (String#1882, DoABC#2)
// RoomInstance = "_-2OS" (String#1870, DoABC#2)
// RoomInstance = "_-sJ" (String#8743, DoABC#2)
// IRoomInstance = "_-1j8" (String#5739, DoABC#2)
// IRoomRendererBase = "_-0Eq" (String#3847, DoABC#2)
// RoomInstance = "_-09y" (String#1415, DoABC#2)
// RoomInstance = "_-1GT" (String#844, DoABC#2)


