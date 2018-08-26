
package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    public class ItemDataStructure 
    {

        private var _itemID:int;
        private var _itemType:String;
        private var _roomItemID:int;
        private var _itemTypeID:int;
        private var _category:int;
        private var _stuffData:String;
        private var _extra:int;
        private var _timeToExpiration:int;
        private var _creationDay:int;
        private var _creationMonth:int;
        private var _creationYear:int;
        private var _groupable:Boolean;
        private var _SafeStr_4009:int;

        public function ItemDataStructure(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:String, _arg_7:int, _arg_8:int, _arg_9:int, _arg_10:int, _arg_11:int, _arg_12:Boolean)
        {
            this._itemID = _arg_1;
            this._itemType = _arg_2;
            this._roomItemID = _arg_3;
            this._itemTypeID = _arg_4;
            this._category = _arg_5;
            this._stuffData = _arg_6;
            this._extra = _arg_7;
            this._timeToExpiration = _arg_8;
            this._creationDay = _arg_9;
            this._creationMonth = _arg_10;
            this._creationYear = _arg_11;
            this._groupable = _arg_12;
        }
        public function get itemID():int
        {
            return (this._itemID);
        }
        public function get itemType():String
        {
            return (this._itemType);
        }
        public function get roomItemID():int
        {
            return (this._roomItemID);
        }
        public function get itemTypeID():int
        {
            return (this._itemTypeID);
        }
        public function get category():int
        {
            return (this._category);
        }
        public function get stuffData():String
        {
            return (this._stuffData);
        }
        public function get extra():int
        {
            return (this._extra);
        }
        public function get timeToExpiration():int
        {
            return (this._timeToExpiration);
        }
        public function get creationDay():int
        {
            return (this._creationDay);
        }
        public function get creationMonth():int
        {
            return (this._creationMonth);
        }
        public function get creationYear():int
        {
            return (this._creationYear);
        }
        public function get groupable():Boolean
        {
            return (this._groupable);
        }
        public function get songID():int
        {
            return (this._extra);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.trading

// ItemDataStructure = "_-2zB" (String#21429, DoABC#2)
// _itemType = "_-0dA" (String#242, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// _itemID = "_-zI" (String#2231, DoABC#2)
// _roomItemID = "_-1ZU" (String#17870, DoABC#2)
// _itemTypeID = "_-2os" (String#21036, DoABC#2)
// _stuffData = "_-1XY" (String#365, DoABC#2)
// _extra = "_-2Rq" (String#246, DoABC#2)
// _timeToExpiration = "_-2Pm" (String#20034, DoABC#2)
// _creationDay = "_-3Jz" (String#7701, DoABC#2)
// _creationMonth = "_-zn" (String#8877, DoABC#2)
// _creationYear = "_-26D" (String#6169, DoABC#2)
// _groupable = "_-1zP" (String#1790, DoABC#2)
// _SafeStr_4009 = "_-ue" (String#24476, DoABC#2)
// itemID = "_-103" (String#16469, DoABC#2)
// roomItemID = "_-07X" (String#14347, DoABC#2)
// itemTypeID = "_-33B" (String#21627, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// timeToExpiration = "_-0VG" (String#15254, DoABC#2)
// creationDay = "_-0jt" (String#15824, DoABC#2)
// creationMonth = "_-1T6" (String#17629, DoABC#2)
// creationYear = "_-0Ts" (String#15202, DoABC#2)
// groupable = "_-1YM" (String#5527, DoABC#2)
// songID = "_-367" (String#21734, DoABC#2)


