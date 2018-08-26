
package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorInitMessageParser implements IMessageParser 
    {

        private var _data:ModeratorInitData;

        public function flush():Boolean
        {
            if (this._data != null){
                this._data.dispose();
                this._data = null;
            };
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new ModeratorInitData(_arg_1);
            return (true);
        }
        public function get data():ModeratorInitData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ModeratorInitData = "_-0W" (String#4229, DoABC#2)
// ModeratorInitMessageParser = "_-1ZK" (String#5549, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


