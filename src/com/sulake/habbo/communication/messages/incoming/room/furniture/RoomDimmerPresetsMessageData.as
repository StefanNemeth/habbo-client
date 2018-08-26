
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    public class RoomDimmerPresetsMessageData 
    {

        private var _id:int = 0;
        private var _type:int = 0;
        private var _color:uint = 0;
        private var _light:uint = 0;
        private var _SafeStr_4520:Boolean = false;

        public function RoomDimmerPresetsMessageData(_arg_1:int)
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
        public function get color():uint
        {
            return (this._color);
        }
        public function set color(_arg_1:uint):void
        {
            if (!this._SafeStr_4520){
                this._color = _arg_1;
            };
        }
        public function get light():int
        {
            return (this._light);
        }
        public function set light(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._light = _arg_1;
            };
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// RoomDimmerPresetsMessageData = "_-0sE" (String#4690, DoABC#2)
// setReadOnly = "_-5p" (String#22456, DoABC#2)
// _light = "_-dT" (String#462, DoABC#2)
// _SafeStr_4520 = "_-18k" (String#440, DoABC#2)


