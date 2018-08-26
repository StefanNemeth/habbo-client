
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomEntryInfoMessageParser implements IMessageParser 
    {

        private var _privateRoom:Boolean;
        private var _guestRoomId:int;
        private var _owner:Boolean;
        private var _publicSpace:PublicRoomShortData;

        public function get privateRoom():Boolean
        {
            return (this._privateRoom);
        }
        public function get guestRoomId():int
        {
            return (this._guestRoomId);
        }
        public function get publicSpace():PublicRoomShortData
        {
            return (this._publicSpace);
        }
        public function get owner():Boolean
        {
            return (this._owner);
        }
        public function flush():Boolean
        {
            if (this._publicSpace != null){
                this._publicSpace.dispose();
                this._publicSpace = null;
            };
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._privateRoom = _arg_1.readBoolean();
            if (this._privateRoom){
                this._guestRoomId = _arg_1.readInteger();
                this._owner = _arg_1.readBoolean();
            }
            else {
                this._publicSpace = new PublicRoomShortData(_arg_1);
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PublicRoomShortData = "_-0ae" (String#4315, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _privateRoom = "_-3b" (String#22358, DoABC#2)
// _guestRoomId = "_-po" (String#24266, DoABC#2)
// _publicSpace = "_-21P" (String#19068, DoABC#2)
// privateRoom = "_-26S" (String#19271, DoABC#2)
// guestRoomId = "_-1NR" (String#17415, DoABC#2)
// publicSpace = "_-1JR" (String#17253, DoABC#2)
// owner = "_-1S6" (String#17586, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// RoomEntryInfoMessageParser = "_-2Z9" (String#6747, DoABC#2)


