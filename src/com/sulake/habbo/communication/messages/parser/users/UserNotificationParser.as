
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserNotificationParser implements IMessageParser 
    {

        private var _title:String = "";
        private var _message:String = "";
        private var _parameters:Array;

        public function get title():String
        {
            return (this._title);
        }
        public function get message():String
        {
            return (this._message);
        }
        public function get parameters():Array
        {
            return (this._parameters);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._title = _arg_1.readString();
            this._message = _arg_1.readString();
            this._parameters = new Array();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._parameters.push(_arg_1.readString());
                this._parameters.push(_arg_1.readString());
                _local_3++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.users

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// UserNotificationParser = "_-6X" (String#7796, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _parameters = "_-r-" (String#945, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


