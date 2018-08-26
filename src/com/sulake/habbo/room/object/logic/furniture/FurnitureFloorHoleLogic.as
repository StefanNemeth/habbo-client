
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room.events.RoomObjectFloorHoleEvent;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureFloorHoleLogic extends FurnitureMultiStateLogic 
    {

        private static const _SafeStr_12481:int = 0;

        private var _SafeStr_7903:int = -1;
        private var _RoomCamera:Vector3d = null;

        override public function dispose():void
        {
            if (this._SafeStr_7903 == _SafeStr_12481){
                eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent(RoomObjectFloorHoleEvent.RORPFHUM_REMOVE, object.getId(), object.getType()));
            };
            super.dispose();
        }
        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectFloorHoleEvent.RORPFHUM_ADD, RoomObjectFloorHoleEvent.RORPFHUM_REMOVE];
            return (ObjectLogicBase(super.getEventTypes(), _local_1));
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:RoomObjectDataUpdateMessage;
            var _local_3:IVector3d;
            var _local_4:int;
            super.processUpdateMessage(_arg_1);
            if (object != null){
                _local_2 = (_arg_1 as RoomObjectDataUpdateMessage);
                if (_local_2 != null){
                    _local_4 = object.getState(0);
                    if (_local_4 != this._SafeStr_7903){
                        if (eventDispatcher != null){
                            if (_local_4 == _SafeStr_12481){
                                eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent(RoomObjectFloorHoleEvent.RORPFHUM_ADD, object.getId(), object.getType()));
                            }
                            else {
                                if (this._SafeStr_7903 == _SafeStr_12481){
                                    eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent(RoomObjectFloorHoleEvent.RORPFHUM_REMOVE, object.getId(), object.getType()));
                                };
                            };
                        };
                        this._SafeStr_7903 = _local_4;
                    };
                };
                _local_3 = object.getLocation();
                if (this._RoomCamera == null){
                    this._RoomCamera = new Vector3d();
                }
                else {
                    if (((!((_local_3.x == this._RoomCamera.x))) || (!((_local_3.y == this._RoomCamera.y))))){
                        if (this._SafeStr_7903 == _SafeStr_12481){
                            if (eventDispatcher != null){
                                eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent(RoomObjectFloorHoleEvent.RORPFHUM_ADD, object.getId(), object.getType()));
                            };
                        };
                    };
                };
                this._RoomCamera.assign(_local_3);
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// _SafeStr_12481 = "_-08J" (String#14376, DoABC#2)
// _RoomCamera = "_-1Xk" (String#5512, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// FurnitureMultiStateLogic = "_-23" (String#6104, DoABC#2)
// FurnitureFloorHoleLogic = "_-2e-" (String#20603, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectDataUpdateMessage = "_-2N4" (String#19928, DoABC#2)
// RoomObjectFloorHoleEvent = "_-2j-" (String#20806, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// RORPFHUM_ADD = "_-wb" (String#24555, DoABC#2)
// RORPFHUM_REMOVE = "_-0CG" (String#14540, DoABC#2)
// _SafeStr_7903 = "_-04-" (String#577, DoABC#2)


