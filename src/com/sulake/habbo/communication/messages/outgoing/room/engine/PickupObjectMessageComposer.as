
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;

    public class PickupObjectMessageComposer implements IMessageComposer 
    {

        private var _objectId:int;
        private var _objectCategory:int;
        private var _roomId:int;
        private var _roomCategory:int;

        public function PickupObjectMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int=0, _arg_4:int=0)
        {
            this._objectId = _arg_1;
            this._objectCategory = _arg_2;
            this._roomId = _arg_3;
            this._roomCategory = _arg_4;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            var _local_1:int;
            switch (this._objectCategory){
                case RoomObjectCategoryEnum._SafeStr_4329:
                    _local_1 = 2;
                    break;
                case RoomObjectCategoryEnum._SafeStr_4330:
                    _local_1 = 1;
                    break;
                default:
                    return ([]);
            };
            return ([_local_1, this._objectId]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.engine

// PickupObjectMessageComposer = "_-0Oc" (String#15012, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _objectCategory = "_-2Bf" (String#367, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)


