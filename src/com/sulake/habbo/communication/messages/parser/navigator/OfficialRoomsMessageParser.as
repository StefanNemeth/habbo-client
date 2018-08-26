
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsData;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OfficialRoomsMessageParser implements IMessageParser 
    {

        private var _data:OfficialRoomsData;
        private var _adRoom:OfficialRoomEntryData;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new OfficialRoomsData(_arg_1);
            var _local_2:int = _arg_1.readInteger();
            if (_local_2 > 0){
                this._adRoom = new OfficialRoomEntryData(_arg_1);
            };
            return (true);
        }
        public function get data():OfficialRoomsData
        {
            return (this._data);
        }
        public function get adRoom():OfficialRoomEntryData
        {
            return (this._adRoom);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// OfficialRoomEntryData = "_-0vy" (String#4767, DoABC#2)
// OfficialRoomsData = "_-pq" (String#8704, DoABC#2)
// OfficialRoomsMessageParser = "_-28N" (String#6209, DoABC#2)
// adRoom = "_-m" (String#24110, DoABC#2)
// _adRoom = "_-0N8" (String#4022, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


