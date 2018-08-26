
package com.sulake.room.object.logic
{
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.events.IEventDispatcher;

    public interface IRoomObjectEventHandler extends IRoomObjectMouseHandler 
    {

        function set object(_arg_1:IRoomObjectController):void;
        function get object():IRoomObjectController;
        function dispose():void;
        function initialize(_arg_1:XML):void;
        function update(_arg_1:int):void;
        function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void;
        function useObject():void;
        function set eventDispatcher(_arg_1:IEventDispatcher):void;
        function get eventDispatcher():IEventDispatcher;
        function getEventTypes():Array;

    }
}//package com.sulake.room.object.logic

// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// IRoomObjectMouseHandler = "_-2xI" (String#7227, DoABC#2)
// IRoomObjectEventHandler = "_-2c8" (String#6797, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)


