
package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    public class FurniData 
    {

        private var _stripId:int;
        private var _itemType:String;
        private var _objId:int;
        private var _classId:int;
        private var _category:int;
        private var _stuffData:String;
        private var _isGroupable:Boolean;
        private var _isRecyclable:Boolean;
        private var _isTradeable:Boolean;
        private var _isSellable:Boolean;
        private var _expiryTime:int;
        private var _extra:int;
        private var _slotId:String = "";
        private var _songId:int = -1;

        public function FurniData(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:String, _arg_7:Boolean, _arg_8:Boolean, _arg_9:Boolean, _arg_10:Boolean, _arg_11:int)
        {
            this._stripId = _arg_1;
            this._itemType = _arg_2;
            this._objId = _arg_3;
            this._classId = _arg_4;
            this._category = _arg_5;
            this._stuffData = _arg_6;
            this._isGroupable = _arg_7;
            this._isRecyclable = _arg_8;
            this._isTradeable = _arg_9;
            this._isSellable = _arg_10;
            this._expiryTime = _arg_11;
        }
        public function setExtraData(_arg_1:String, _arg_2:int):void
        {
            this._slotId = _arg_1;
            this._extra = _arg_2;
        }
        public function get stripId():int
        {
            return (this._stripId);
        }
        public function get itemType():String
        {
            return (this._itemType);
        }
        public function get objId():int
        {
            return (this._objId);
        }
        public function get classId():int
        {
            return (this._classId);
        }
        public function get category():int
        {
            return (this._category);
        }
        public function get stuffData():String
        {
            return (this._stuffData);
        }
        public function get isGroupable():Boolean
        {
            return (this._isGroupable);
        }
        public function get isRecyclable():Boolean
        {
            return (this._isRecyclable);
        }
        public function get isTradeable():Boolean
        {
            return (this._isTradeable);
        }
        public function get isSellable():Boolean
        {
            return (this._isSellable);
        }
        public function get expiryTime():int
        {
            return (this._expiryTime);
        }
        public function get slotId():String
        {
            return (this._slotId);
        }
        public function get songId():int
        {
            return (this._songId);
        }
        public function get extra():int
        {
            return (this._extra);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.furni

// FurniData = "_-2AO" (String#19422, DoABC#2)
// _itemType = "_-0dA" (String#242, DoABC#2)
// _classId = "_-172" (String#597, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// classId = "_-1mV" (String#18401, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// expiryTime = "_-1FG" (String#17083, DoABC#2)
// _stuffData = "_-1XY" (String#365, DoABC#2)
// _extra = "_-2Rq" (String#246, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// _expiryTime = "_-0Tk" (String#1482, DoABC#2)
// _songId = "_-0a-" (String#241, DoABC#2)
// setExtraData = "_-2NQ" (String#19941, DoABC#2)
// stripId = "_-28E" (String#19340, DoABC#2)
// songId = "_-2fw" (String#20688, DoABC#2)
// _slotId = "_-34j" (String#911, DoABC#2)
// objId = "_-1VD" (String#17710, DoABC#2)
// isGroupable = "_-19p" (String#16849, DoABC#2)
// isTradeable = "_-2td" (String#21226, DoABC#2)
// isRecyclable = "_-1jA" (String#18251, DoABC#2)
// isSellable = "_-0aB" (String#4305, DoABC#2)
// _stripId = "_-dH" (String#2144, DoABC#2)
// _isGroupable = "_-1E1" (String#17028, DoABC#2)
// _isRecyclable = "_-2Y8" (String#20360, DoABC#2)
// _isTradeable = "_-0Xd" (String#15341, DoABC#2)
// _isSellable = "_-3JW" (String#7695, DoABC#2)


