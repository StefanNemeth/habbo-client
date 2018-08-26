
package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomVisitsMessageParser implements IMessageParser 
    {

        private var _data:RoomVisitsData;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new RoomVisitsData(_arg_1);
            return (true);
        }
        public function get data():RoomVisitsData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomVisitsMessageParser = "_-2zM" (String#7274, DoABC#2)
// RoomVisitsData = "_-0EM" (String#3834, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


