
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class PublicRoomObjectMessageData 
    {

        private var _name:String = "";
        private var _type:String = "";
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _z:Number = 0;
        private var _dir:int = 0;
        private var _sizeX:int = 0;
        private var _sizeY:int = 0;
        private var _SafeStr_4520:Boolean = false;

        public function setReadOnly():void
        {
            this._SafeStr_4520 = true;
        }
        public function get type():String
        {
            return (this._type);
        }
        public function set type(_arg_1:String):void
        {
            if (!this._SafeStr_4520){
                this._type = _arg_1;
            };
        }
        public function get name():String
        {
            return (this._name);
        }
        public function set name(_arg_1:String):void
        {
            if (!this._SafeStr_4520){
                this._name = _arg_1;
            };
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

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// PublicRoomObjectMessageData = "_-6" (String#7780, DoABC#2)
// setReadOnly = "_-5p" (String#22456, DoABC#2)
// sizeX = "_-0UO" (String#15219, DoABC#2)
// sizeY = "_-wz" (String#24569, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// _dir = "_-1kY" (String#187, DoABC#2)
// _SafeStr_4520 = "_-18k" (String#440, DoABC#2)
// _z = "_-0kf" (String#215, DoABC#2)
// _sizeX = "_-sQ" (String#946, DoABC#2)
// _sizeY = "_-36G" (String#912, DoABC#2)


