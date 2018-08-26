
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomEventMessageParser implements IMessageParser 
    {

        private var _data:RoomEventData;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new RoomEventData(_arg_1);
            return (true);
        }
        public function get data():RoomEventData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomEventData = "_-07q" (String#3718, DoABC#2)
// RoomEventMessageParser = "_-1on" (String#5836, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


