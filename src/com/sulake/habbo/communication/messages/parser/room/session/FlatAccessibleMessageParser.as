
package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatAccessibleMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _userName:String = null;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._userName = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 != null){
                this._userName = _arg_1.readString();
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.session

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FlatAccessibleMessageParser = "_-1d1" (String#5616, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


