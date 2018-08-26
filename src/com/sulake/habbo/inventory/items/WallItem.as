
package com.sulake.habbo.inventory.items
{
    public class WallItem implements IItem 
    {

        protected var _id:int;
        protected var _type:int;
        protected var _ref:int;
        protected var _category:int;
        protected var _extra:Number;
        protected var _stuffData:String;
        protected var _recyclable:Boolean;
        protected var _tradeable:Boolean;
        protected var _groupable:Boolean;
        protected var _sellable:Boolean;
        protected var _locked:Boolean;

        public function WallItem(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean, _arg_8:Boolean, _arg_9:String, _arg_10:Number)
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
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get type():int
        {
            return (this._type);
        }
        public function get ref():int
        {
            return (this._ref);
        }
        public function get category():int
        {
            return (this._category);
        }
        public function get extra():Number
        {
            return (this._extra);
        }
        public function get stuffData():String
        {
            return (this._stuffData);
        }
        public function set stuffData(_arg_1:String):void
        {
            this._stuffData = _arg_1;
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
        public function get locked():Boolean
        {
            return (this._locked);
        }
        public function set locked(_arg_1:Boolean):void
        {
            this._locked = _arg_1;
        }

    }
}//package com.sulake.habbo.inventory.items

// _sellable = "_-1dK" (String#1726, DoABC#2)
// recyclable = "_-A8" (String#7868, DoABC#2)
// _recyclable = "_-1kN" (String#5756, DoABC#2)
// _tradeable = "_-2cK" (String#6800, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// WallItem = "_-2ZP" (String#20413, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// _stuffData = "_-1XY" (String#365, DoABC#2)
// _extra = "_-2Rq" (String#246, DoABC#2)
// _groupable = "_-1zP" (String#1790, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// groupable = "_-1YM" (String#5527, DoABC#2)
// ref = "_-Jx" (String#8081, DoABC#2)
// tradeable = "_-3E5" (String#7597, DoABC#2)
// _locked = "_-2vv" (String#902, DoABC#2)


