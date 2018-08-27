
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class ObjectMessageData 
    {

        private var _id:int = 0;
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _z:Number = 0;
        private var _dir:int = 0;
        private var _sizeX:int = 0;
        private var _sizeY:int = 0;
        private var _type:int = 0;
        private var _SafeStr_5154:String = "";
        private var _extra:int = -1;
        private var _state:int = 0;
        private var _data:String = "";
        private var _expiryTime:int = 0;
        private var _knownAsUsable:Boolean;
        private var _staticClass:String = null;
        private var _SafeStr_4520:Boolean = false;

        public function ObjectMessageData(_arg_1:int)
        {
            this._id = _arg_1;
        }
        public function setReadOnly():void
        {
            this._SafeStr_4520 = true;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get x():Number
        {
            return (this._x);
        }
        public function set x(_arg_1:Number):void
        {
            if (!this._SafeStr_4520){
                this._x = _arg_1;
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
        public function get dir():int
        {
            return (this._dir);
        }
        public function set dir(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._dir = _arg_1;
            };
        }
        public function get sizeX():int
        {
            return (this._sizeX);
        }
        public function set sizeX(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._sizeX = _arg_1;
            };
        }
        public function get sizeY():int
        {
            return (this._sizeY);
        }
        public function set sizeY(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._sizeY = _arg_1;
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
        public function get staticClass():String
        {
            return (this._staticClass);
        }
        public function set staticClass(_arg_1:String):void
        {
            if (!this._SafeStr_4520){
                this._staticClass = _arg_1;
            };
        }
        public function get extra():int
        {
            return (this._extra);
        }
        public function set extra(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._extra = _arg_1;
            };
        }
        public function get expiryTime():int
        {
            return (this._expiryTime);
        }
        public function set expiryTime(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._expiryTime = _arg_1;
            };
        }
        public function get knownAsUsable():Boolean
        {
            return (this._knownAsUsable);
        }
        public function set knownAsUsable(_arg_1:Boolean):void
        {
            this._knownAsUsable = _arg_1;
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ObjectMessageData = "_-0jV" (String#4490, DoABC#2)
// setReadOnly = "_-5p" (String#22456, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// expiryTime = "_-1FG" (String#17083, DoABC#2)
// staticClass = "_-1HW" (String#17170, DoABC#2)
// sizeX = "_-0UO" (String#15219, DoABC#2)
// sizeY = "_-wz" (String#24569, DoABC#2)
// _extra = "_-2Rq" (String#246, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// _dir = "_-1kY" (String#187, DoABC#2)
// _SafeStr_4520 = "_-18k" (String#440, DoABC#2)
// _z = "_-0kf" (String#215, DoABC#2)
// _sizeX = "_-sQ" (String#946, DoABC#2)
// _sizeY = "_-36G" (String#912, DoABC#2)
// _SafeStr_5154 = "_-2Mh" (String#6494, DoABC#2)
// _knownAsUsable = "_-1du" (String#1729, DoABC#2)
// _expiryTime = "_-0Tk" (String#1482, DoABC#2)
// _staticClass = "_-0zb" (String#16411, DoABC#2)


