
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserTagsMessageParser implements IMessageParser 
    {

        protected var _tags:Array;
        protected var _userId:int = 0;

        public function UserTagsMessageParser()
        {
            this._tags = [];
            super();
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._tags = [];
            this._userId = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._tags.push(_arg_1.readString());
                _local_3++;
            };
            return (true);
        }
        public function get tags():Array
        {
            return (this._tags.slice());
        }
        public function get userId():int
        {
            return (this._userId);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.users

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// UserTagsMessageParser = "_-11M" (String#4902, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _tags = "_-1NU" (String#163, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


