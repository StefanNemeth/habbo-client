
package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.moderation.UserChatlogData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserChatlogMessageParser implements IMessageParser 
    {

        private var _data:UserChatlogData;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new UserChatlogData(_arg_1);
            return (true);
        }
        public function get data():UserChatlogData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// UserChatlogMessageParser = "_-2Oi" (String#6535, DoABC#2)
// UserChatlogData = "_-3BV" (String#7540, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


