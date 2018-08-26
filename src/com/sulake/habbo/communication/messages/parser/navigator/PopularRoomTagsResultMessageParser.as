
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PopularRoomTagsResultMessageParser implements IMessageParser 
    {

        private var _data:PopularRoomTagsData;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new PopularRoomTagsData(_arg_1);
            return (true);
        }
        public function get data():PopularRoomTagsData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PopularRoomTagsData = "_-1Bn" (String#5105, DoABC#2)
// PopularRoomTagsResultMessageParser = "_-2EG" (String#6326, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


