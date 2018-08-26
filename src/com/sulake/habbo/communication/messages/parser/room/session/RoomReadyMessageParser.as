
package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomReadyMessageParser implements IMessageParser 
    {

        private var _roomType:String = "";
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function get roomType():String
        {
            return (this._roomType);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function flush():Boolean
        {
            this._roomType = "";
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._roomType = _arg_1.readString();
            this._roomId = _arg_1.readInteger();
            if (this._roomType.indexOf("model_") < 0){
                this._roomCategory = 1;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.session

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomReadyMessageParser = "_-1zm" (String#18958, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _roomType = "_-2D8" (String#1834, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


