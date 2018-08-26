
package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomModerationData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorRoomInfoMessageParser implements IMessageParser 
    {

        private var _data:RoomModerationData;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new RoomModerationData(_arg_1);
            return (true);
        }
        public function get data():RoomModerationData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ModeratorRoomInfoMessageParser = "_-1aP" (String#5567, DoABC#2)
// RoomModerationData = "_-1Zn" (String#5559, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


