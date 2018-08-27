
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class ItemMessageData 
    {

        private var _id:int = 0;
        private var _isOldFormat:Boolean = false;
        private var _wallX:int = 0;
        private var _wallY:int = 0;
        private var _localX:int = 0;
        private var _localY:int = 0;
        private var _y:Number = 0;
        private var _z:Number = 0;
        private var _dir:String = "";
        private var _type:int = 0;
        private var _SafeStr_5154:String = "";
        private var _extra:int = 0;
        private var _state:int = 0;
        private var _data:String = "";
        private var _SafeStr_4520:Boolean = false;
        private var _knownAsUsable:Boolean;

        public function ItemMessageData(_arg_1:int, _arg_2:int, _arg_3:Boolean)
        {
            this._id = _arg_1;
            this._type = _arg_2;
            this._isOldFormat = _arg_3;
        }
        public function setReadOnly():void
        {
            this._SafeStr_4520 = true;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get isOldFormat():Boolean
        {
            return (this._isOldFormat);
        }
        public function get wallX():Number
        {
            return (this._wallX);
        }
        public function set wallX(_arg_1:Number):void
        {
            if (!this._SafeStr_4520){
                this._wallX = _arg_1;
            };
        }
        public function get wallY():Number
        {
            return (this._wallY);
        }
        public function set wallY(_arg_1:Number):void
        {
            if (!this._SafeStr_4520){
                this._wallY = _arg_1;
            };
        }
        public function get localX():Number
        {
            return (this._localX);
        }
        public function set localX(_arg_1:Number):void
        {
            if (!this._SafeStr_4520){
                this._localX = _arg_1;
            };
        }
        public function get localY():Number
        {
            return (this._localY);
        }
        public function set localY(_arg_1:Number):void
        {
            if (!this._SafeStr_4520){
                this._localY = _arg_1;
            };
        }
        public function get y():Number
        {
            return (this._y);
        }
        public function set y(_arg_1:Number):void
        {
            if (!this._SafeStr_4520){
                this._y = _arg_1;
            };
        }
        public function get z():Number
        {
            return (this._z);
        }
        public function set z(_arg_1:Number):void
        {
            if (!this._SafeStr_4520){
                this._z = _arg_1;
            };
        }
        public function get dir():String
        {
            return (this._dir);
        }
        public function set dir(_arg_1:String):void
        {
            if (!this._SafeStr_4520){
                this._dir = _arg_1;
            };
        }
        public function get type():int
        {
            return (this._type);
        }
        public function set type(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._type = _arg_1;
            };
        }
        public function get state():int
        {
            return (this._state);
        }
        public function set state(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._state = _arg_1;
            };
        }
        public function get data():String
        {
            return (this._data);
        }
        public function set data(_arg_1:String):void
        {
            if (!this._SafeStr_4520){
                this._data = _arg_1;
            };
        }
        public function get knownAsUsable():Boolean
        {
            return (this._knownAsUsable);
        }
        public function set knownAsUsable(_arg_1:Boolean):void
        {
            if (!this._SafeStr_4520){
                this._knownAsUsable = _arg_1;
            };
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ItemMessageData = "_-1Nr" (String#5309, DoABC#2)
// setReadOnly = "_-5p" (String#22456, DoABC#2)
// wallX = "_-0Jc" (String#14826, DoABC#2)
// wallY = "_-2VK" (String#20254, DoABC#2)
// _extra = "_-2Rq" (String#246, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// _dir = "_-1kY" (String#187, DoABC#2)
// _SafeStr_4520 = "_-18k" (String#440, DoABC#2)
// _z = "_-0kf" (String#215, DoABC#2)
// _isOldFormat = "_-28t" (String#19365, DoABC#2)
// _wallX = "_-R1" (String#23283, DoABC#2)
// _wallY = "_-1z0" (String#18928, DoABC#2)
// _localX = "_-0tq" (String#4720, DoABC#2)
// _localY = "_-0UY" (String#4194, DoABC#2)
// _SafeStr_5154 = "_-2Mh" (String#6494, DoABC#2)
// _knownAsUsable = "_-1du" (String#1729, DoABC#2)
// isOldFormat = "_-0A1" (String#14448, DoABC#2)


