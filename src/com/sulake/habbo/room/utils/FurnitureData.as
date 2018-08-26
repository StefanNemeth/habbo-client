
package com.sulake.habbo.room.utils
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class FurnitureData 
    {

        private var _id:int = 0;
        private var _typeId:int = 0;
        private var _type:String = null;
        private var _loc:Vector3d;
        private var _dir:Vector3d;
        private var _state:int = 0;
        private var _data:String = null;
        private var _extra:Number = NaN;
        private var _expiryTime:int = -1;
        private var _knownAsUsable:Boolean = false;

        public function FurnitureData(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:int, _arg_7:String, _arg_8:Number=NaN, _arg_9:int=-1, _arg_10:Boolean=false)
        {
            this._loc = new Vector3d();
            this._dir = new Vector3d();
            super();
            this._id = _arg_1;
            this._typeId = _arg_2;
            this._type = _arg_3;
            this._loc.assign(_arg_4);
            this._dir.assign(_arg_5);
            this._state = _arg_6;
            this._data = _arg_7;
            this._extra = _arg_8;
            this._expiryTime = _arg_9;
            this._knownAsUsable = _arg_10;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get typeId():int
        {
            return (this._typeId);
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get loc():IVector3d
        {
            return (this._loc);
        }
        public function get dir():IVector3d
        {
            return (this._dir);
        }
        public function get state():int
        {
            return (this._state);
        }
        public function get data():String
        {
            return (this._data);
        }
        public function get extra():Number
        {
            return (this._extra);
        }
        public function get expiryTime():int
        {
            return (this._expiryTime);
        }
        public function get knownAsUsable():Boolean
        {
            return (this._knownAsUsable);
        }

    }
}//package com.sulake.habbo.room.utils

// _typeId = "_-3LT" (String#2045, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// FurnitureData = "_-sW" (String#2211, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// expiryTime = "_-1FG" (String#17083, DoABC#2)
// _extra = "_-2Rq" (String#246, DoABC#2)
// _dir = "_-1kY" (String#187, DoABC#2)
// _knownAsUsable = "_-1du" (String#1729, DoABC#2)
// _loc = "_-0OE" (String#185, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// _expiryTime = "_-0Tk" (String#1482, DoABC#2)


