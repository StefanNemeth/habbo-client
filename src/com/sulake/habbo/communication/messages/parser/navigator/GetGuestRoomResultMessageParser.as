
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GetGuestRoomResultMessageParser implements IMessageParser 
    {

        private var _enterRoom:Boolean;
        private var _roomForward:Boolean;
        private var _staffPick:Boolean;
        private var _data:GuestRoomData;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._enterRoom = _arg_1.readBoolean();
            this._data = new GuestRoomData(_arg_1);
            this._roomForward = _arg_1.readBoolean();
            this._staffPick = _arg_1.readBoolean();
            return (true);
        }
        public function get enterRoom():Boolean
        {
            return (this._enterRoom);
        }
        public function get data():GuestRoomData
        {
            return (this._data);
        }
        public function get roomForward():Boolean
        {
            return (this._roomForward);
        }
        public function get staffPick():Boolean
        {
            return (this._staffPick);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// GetGuestRoomResultMessageParser = "_-0lh" (String#4540, DoABC#2)
// GuestRoomData = "_-06S" (String#3692, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _enterRoom = "_-1l-" (String#18334, DoABC#2)
// _roomForward = "_-1Rj" (String#17573, DoABC#2)
// _staffPick = "_-1EQ" (String#17044, DoABC#2)
// enterRoom = "_-Lu" (String#23077, DoABC#2)
// staffPick = "_-11I" (String#16509, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


