
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;

    public class FurnitureClothingChangeLogic extends FurnitureLogic 
    {

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectWidgetRequestEvent.REOR_REQUEST_CLOTHING_CHANGE];
            return (ObjectLogicBase(super.getEventTypes(), _local_1));
        }
        override public function initialize(_arg_1:XML):void
        {
            super.initialize(_arg_1);
            if ((((object == null)) || ((object.getModel() == null)))){
                return;
            };
            var _local_2:String = object.getModel().getString(RoomObjectVariableEnum._SafeStr_7217);
            this.updateClothingData(_local_2);
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(_arg_1);
            var _local_2:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_2 != null){
                this.updateClothingData(_local_2.data);
            };
        }
        private function updateClothingData(_arg_1:String):void
        {
            var _local_2:Array;
            if (((!((_arg_1 == null))) && ((_arg_1.length > 0)))){
                _local_2 = _arg_1.split(",");
                if (_local_2.length > 0){
                    object.getModelController().setString(RoomObjectVariableEnum._SafeStr_7386, _local_2[0]);
                };
                if (_local_2.length > 1){
                    object.getModelController().setString(RoomObjectVariableEnum._SafeStr_7387, _local_2[1]);
                };
            };
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            if (object == null){
                return;
            };
            switch (_arg_1.type){
                case MouseEvent.DOUBLE_CLICK:
                    this.useObject();
                    return;
                default:
                    super.mouseEvent(_arg_1, _arg_2);
            };
        }
        override public function useObject():void
        {
            var _local_1:int;
            var _local_2:String;
            var _local_3:RoomObjectEvent;
            if (((!((eventDispatcher == null))) && (!((object == null))))){
                _local_1 = object.getId();
                _local_2 = object.getType();
                _local_3 = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.REOR_REQUEST_CLOTHING_CHANGE, _local_1, _local_2);
                eventDispatcher.dispatchEvent(_local_3);
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// updateClothingData = "_-z8" (String#24655, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurnitureClothingChangeLogic = "_-2JY" (String#19792, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectDataUpdateMessage = "_-2N4" (String#19928, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectWidgetRequestEvent = "_-0Oy" (String#15023, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// REOR_REQUEST_CLOTHING_CHANGE = "_-8e" (String#22566, DoABC#2)
// _SafeStr_7217 = "_-1mr" (String#18416, DoABC#2)
// _SafeStr_7386 = "_-ew" (String#23841, DoABC#2)
// _SafeStr_7387 = "_-69" (String#22471, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)


