
package com.sulake.room.events
{
    public class RoomSpriteMouseEvent 
    {

        private var _type:String = "";
        private var _eventId:String = "";
        private var _canvasId:String = "";
        private var _spriteTag:String = "";
        private var _screenX:Number = 0;
        private var _screenY:Number = 0;
        private var _localX:Number = 0;
        private var _localY:Number = 0;
        private var _ctrlKey:Boolean = false;
        private var _altKey:Boolean = false;
        private var _shiftKey:Boolean = false;
        private var _buttonDown:Boolean = false;

        public function RoomSpriteMouseEvent(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Number, _arg_6:Number, _arg_7:Number=0, _arg_8:Number=0, _arg_9:Boolean=false, _arg_10:Boolean=false, _arg_11:Boolean=false, _arg_12:Boolean=false)
        {
            this._type = _arg_1;
            this._eventId = _arg_2;
            this._canvasId = _arg_3;
            this._spriteTag = _arg_4;
            this._screenX = _arg_5;
            this._screenY = _arg_6;
            this._localX = _arg_7;
            this._localY = _arg_8;
            this._ctrlKey = _arg_9;
            this._altKey = _arg_10;
            this._shiftKey = _arg_11;
            this._buttonDown = _arg_12;
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get eventId():String
        {
            return (this._eventId);
        }
        public function get canvasId():String
        {
            return (this._canvasId);
        }
        public function get spriteTag():String
        {
            return (this._spriteTag);
        }
        public function get screenX():Number
        {
            return (this._screenX);
        }
        public function get screenY():Number
        {
            return (this._screenY);
        }
        public function get localX():Number
        {
            return (this._localX);
        }
        public function get localY():Number
        {
            return (this._localY);
        }
        public function get ctrlKey():Boolean
        {
            return (this._ctrlKey);
        }
        public function get altKey():Boolean
        {
            return (this._altKey);
        }
        public function get shiftKey():Boolean
        {
            return (this._shiftKey);
        }
        public function get buttonDown():Boolean
        {
            return (this._buttonDown);
        }

    }
}//package com.sulake.room.events

// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// _localX = "_-0tq" (String#4720, DoABC#2)
// _localY = "_-0UY" (String#4194, DoABC#2)
// spriteTag = "_-1jr" (String#18278, DoABC#2)
// screenX = "_-2jN" (String#20819, DoABC#2)
// screenY = "_-1oK" (String#18472, DoABC#2)
// eventId = "_-3ER" (String#22053, DoABC#2)
// _eventId = "_-19k" (String#1626, DoABC#2)
// _altKey = "_-0ak" (String#4317, DoABC#2)
// _ctrlKey = "_-1iB" (String#5713, DoABC#2)
// _shiftKey = "_-1GO" (String#5175, DoABC#2)
// _buttonDown = "_-2-j" (String#6039, DoABC#2)
// _canvasId = "_-0SO" (String#4146, DoABC#2)
// _spriteTag = "_-1XD" (String#5502, DoABC#2)
// _screenX = "_-1b" (String#17933, DoABC#2)
// _screenY = "_-od" (String#24220, DoABC#2)
// canvasId = "_-1No" (String#17429, DoABC#2)


