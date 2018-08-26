
package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MOTDNotificationParser implements IMessageParser 
    {

        private var _messages:Array;

        public function flush():Boolean
        {
            this._messages = new Array();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._messages.push(_arg_1.readString());
                _local_3++;
            };
            return (true);
        }
        public function get messages():Array
        {
            return (this._messages);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.notifications

// MOTDNotificationParser = "_-0ES" (String#3837, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _messages = "_-1AO" (String#835, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


