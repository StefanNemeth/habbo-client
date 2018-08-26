
package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChatMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _userId:int = 0;
        private var _text:String = "";
        private var _links:Array;
        private var _gesture:int = 0;
        private var _trackingId:int = -1;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get text():String
        {
            return (this._text);
        }
        public function get links():Array
        {
            return (this._links);
        }
        public function get gesture():int
        {
            return (this._gesture);
        }
        public function get trackingId():int
        {
            return (this._trackingId);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._userId = 0;
            this._text = "";
            this._gesture = 0;
            this._links = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            if (_arg_1 == null){
                return (false);
            };
            this._userId = _arg_1.readInteger();
            this._text = _arg_1.readString();
            this._gesture = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            if (_local_2 > 0){
                this._links = new Array();
                _local_3 = 0;
                while (_local_3 < _local_2) {
                    this._links.push([_arg_1.readString(), _arg_1.readString(), _arg_1.readInteger()]);
                    _local_3++;
                };
            };
            this._trackingId = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.chat

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ChatMessageParser = "_-06O" (String#3689, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _gesture = "_-2tH" (String#452, DoABC#2)
// _links = "_-Qt" (String#2105, DoABC#2)
// trackingId = "_-189" (String#16783, DoABC#2)
// _trackingId = "_-ea" (String#23826, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


