
package com.sulake.habbo.communication.messages.incoming.sound
{
    public class PlayListEntry 
    {

        protected var _songId:int;
        protected var _length:int;
        protected var _songName:String;
        protected var _songCreator:String;
        private var _startPlayHeadPos:Number = 0;

        public function PlayListEntry(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String)
        {
            this._songId = _arg_1;
            this._length = _arg_2;
            this._songName = _arg_3;
            this._songCreator = _arg_4;
        }
        public function get id():int
        {
            return (this._songId);
        }
        public function get length():int
        {
            return (this._length);
        }
        public function get name():String
        {
            return (this._songName);
        }
        public function get creator():String
        {
            return (this._songCreator);
        }
        public function get startPlayHeadPos():Number
        {
            return (this._startPlayHeadPos);
        }
        public function set startPlayHeadPos(_arg_1:Number):void
        {
            this._startPlayHeadPos = _arg_1;
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.sound

// PlayListEntry = "_-17H" (String#5021, DoABC#2)
// _songId = "_-0a-" (String#241, DoABC#2)
// _length = "_-15P" (String#16671, DoABC#2)
// _startPlayHeadPos = "_-33s" (String#21654, DoABC#2)
// creator = "_-1U2" (String#5433, DoABC#2)
// startPlayHeadPos = "_-0Xz" (String#15354, DoABC#2)


