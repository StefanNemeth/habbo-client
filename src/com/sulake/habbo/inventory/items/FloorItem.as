
package com.sulake.habbo.inventory.items
{
    public class FloorItem implements IItem 
    {

        protected var _id:int;
        protected var _ref:int;
        protected var _category:int;
        protected var _type:int;
        protected var _stuffData:String;
        protected var _extra:Number;
        protected var _recyclable:Boolean;
        protected var _tradeable:Boolean;
        protected var _groupable:Boolean;
        protected var _sellable:Boolean;
        protected var _expires:int;
        protected var _creationDay:int;
        protected var _creationMonth:int;
        protected var _creationYear:int;
        protected var _slotId:String;
        protected var _songId:int;
        protected var _locked:Boolean;

        public function FloorItem(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean, _arg_8:Boolean, _arg_9:String, _arg_10:Number, _arg_11:int, _arg_12:int, _arg_13:int, _arg_14:int, _arg_15:String, _arg_16:int)
        {
            this._id = _arg_1;
            this._type = _arg_2;
            this._ref = _arg_3;
            this._category = _arg_4;
            this._groupable = _arg_5;
            this._tradeable = _arg_6;
            this._recyclable = _arg_7;
            this._sellable = _arg_8;
            this._stuffData = _arg_9;
            this._extra = _arg_10;
            this._expires = _arg_11;
            this._creationDay = _arg_12;
            this._creationMonth = _arg_13;
            this._creationYear = _arg_14;
            this._slotId = _arg_15;
            this._songId = _arg_16;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get ref():int
        {
            return (this._ref);
        }
        public function get category():int
        {
            return (this._category);
        }
        public function get type():int
        {
            return (this._type);
        }
        public function get stuffData():String
        {
            return (this._stuffData);
        }
        public function get extra():Number
        {
            return (this._extra);
        }
        public function get recyclable():Boolean
        {
            return (this._recyclable);
        }
        public function get tradeable():Boolean
        {
            return (this._tradeable);
        }
        public function get groupable():Boolean
        {
            return (this._groupable);
        }
        public function get sellable():Boolean
        {
            return (this._sellable);
        }
        public function get expires():int
        {
            return (this._expires);
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
        public function get slotId():String
        {
            return (this._slotId);
        }
        public function get songId():int
        {
            return (this._songId);
        }
        public function set locked(_arg_1:Boolean):void
        {
            this._locked = _arg_1;
        }
        public function get locked():Boolean
        {
            return (this._locked);
        }

    }
}//package com.sulake.habbo.inventory.items

// _sellable = "_-1dK" (String#1726, DoABC#2)
// recyclable = "_-A8" (String#7868, DoABC#2)
// _recyclable = "_-1kN" (String#5756, DoABC#2)
// _tradeable = "_-2cK" (String#6800, DoABC#2)
// _expires = "_-25S" (String#19237, DoABC#2)
// expires = "_-37O" (String#21784, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// FloorItem = "_-2DW" (String#19547, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// _stuffData = "_-1XY" (String#365, DoABC#2)
// _extra = "_-2Rq" (String#246, DoABC#2)
// _creationDay = "_-3Jz" (String#7701, DoABC#2)
// _creationMonth = "_-zn" (String#8877, DoABC#2)
// _creationYear = "_-26D" (String#6169, DoABC#2)
// _groupable = "_-1zP" (String#1790, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// creationDay = "_-0jt" (String#15824, DoABC#2)
// creationMonth = "_-1T6" (String#17629, DoABC#2)
// creationYear = "_-0Ts" (String#15202, DoABC#2)
// groupable = "_-1YM" (String#5527, DoABC#2)
// _songId = "_-0a-" (String#241, DoABC#2)
// songId = "_-2fw" (String#20688, DoABC#2)
// _slotId = "_-34j" (String#911, DoABC#2)
// ref = "_-Jx" (String#8081, DoABC#2)
// tradeable = "_-3E5" (String#7597, DoABC#2)
// _locked = "_-2vv" (String#902, DoABC#2)


