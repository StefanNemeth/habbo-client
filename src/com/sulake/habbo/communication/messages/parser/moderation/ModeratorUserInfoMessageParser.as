
package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorUserInfoData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorUserInfoMessageParser implements IMessageParser 
    {

        private var _data:ModeratorUserInfoData;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new ModeratorUserInfoData(_arg_1);
            return (true);
        }
        public function get data():ModeratorUserInfoData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ModeratorUserInfoMessageParser = "_-0E5" (String#3829, DoABC#2)
// ModeratorUserInfoData = "_-0Cn" (String#3805, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


