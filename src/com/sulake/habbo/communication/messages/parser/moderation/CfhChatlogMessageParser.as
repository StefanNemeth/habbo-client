
package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.moderation.CfhChatlogData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CfhChatlogMessageParser implements IMessageParser 
    {

        private var _data:CfhChatlogData;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new CfhChatlogData(_arg_1);
            return (true);
        }
        public function get data():CfhChatlogData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// CfhChatlogMessageParser = "_-2Gb" (String#6379, DoABC#2)
// CfhChatlogData = "_-34O" (String#7397, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


