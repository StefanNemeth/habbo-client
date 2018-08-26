
package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FloodControlMessageParser implements IMessageParser 
    {

        private var _seconds:int = 0;

        public function get seconds():int
        {
            return (this._seconds);
        }
        public function flush():Boolean
        {
            this._seconds = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._seconds = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.chat

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FloodControlMessageParser = "_-1ML" (String#5281, DoABC#2)
// _seconds = "_-098" (String#3741, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


