
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;

    public class PlaceObjectMessageComposer implements IMessageComposer 
    {

        private var _objectId:int;
        private var _objectCategory:int;
        private var _wallLocation:String;
        private var _x:int = 0;
        private var _y:int = 0;
        private var _dir:int = 0;
        private var _roomId:int;
        private var _roomCategory:int;

        public function PlaceObjectMessageComposer(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int=0, _arg_8:int=0)
        {
            this._objectId = _arg_1;
            this._objectCategory = _arg_2;
            this._wallLocation = _arg_3;
            this._x = _arg_4;
            this._y = _arg_5;
            this._dir = _arg_6;
            this._roomId = _arg_7;
            this._roomCategory = _arg_8;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            switch (this._objectCategory){
                case RoomObjectCategoryEnum._SafeStr_4329:
                    return ([((((((this._objectId + " ") + this._x) + " ") + this._y) + " ") + this._dir)]);
                case RoomObjectCategoryEnum._SafeStr_4330:
                    return ([((this._objectId + " ") + this._wallLocation)]);
                default:
                    return ([]);
            };
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.engine

// PlaceObjectMessageComposer = "_-1To" (String#17657, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _objectCategory = "_-2Bf" (String#367, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _wallLocation = "_-1p1" (String#1763, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// _dir = "_-1kY" (String#187, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)


