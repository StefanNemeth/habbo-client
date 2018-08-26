
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class FurnitureFireworksLogic extends FurnitureLogic 
    {

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE];
            return (ObjectLogicBase(super.getEventTypes(), _local_1));
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_5:RoomObjectEvent;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            if (object == null){
                return;
            };
            var _local_3:int = object.getId();
            var _local_4:String = object.getType();
            switch (_arg_1.type){
                case MouseEvent.DOUBLE_CLICK:
                    switch (_arg_1.spriteTag){
                        case "start_stop":
                            _local_5 = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE, _local_3, _local_4, 1);
                            break;
                        case "reset":
                            _local_5 = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE, _local_3, _local_4, 2);
                            break;
                    };
                    break;
            };
            if (((!((eventDispatcher == null))) && (!((_local_5 == null))))){
                eventDispatcher.dispatchEvent(_local_5);
            }
            else {
                super.mouseEvent(_arg_1, _arg_2);
            };
        }
        override public function useObject():void
        {
            var _local_1:int;
            var _local_2:String;
            var _local_3:RoomObjectEvent;
            if (object != null){
                _local_1 = object.getId();
                _local_2 = object.getType();
                _local_3 = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE, _local_1, _local_2, 0);
                if (eventDispatcher != null){
                    eventDispatcher.dispatchEvent(_local_3);
                };
            };
        }
        override public function initialize(_arg_1:XML):void
        {
            var _local_3:IRoomObjectModelController;
            super.initialize(_arg_1);
            if (_arg_1 == null){
                return;
            };
            var _local_2:XMLList = _arg_1.particlesystems;
            if (_local_2.length() == 0){
                return;
            };
            if (object != null){
                _local_3 = object.getModelController();
                if (_local_3 != null){
                    _local_3.setString(RoomObjectVariableEnum._SafeStr_12453, String(_local_2));
                };
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// _SafeStr_12453 = "_-C4" (String#22694, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurnitureFireworksLogic = "_-306" (String#21505, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectStateChangeEvent = "_-2D1" (String#19524, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// spriteTag = "_-1jr" (String#18278, DoABC#2)
// ROSCE_STATE_CHANGE = "_-RU" (String#23304, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)


