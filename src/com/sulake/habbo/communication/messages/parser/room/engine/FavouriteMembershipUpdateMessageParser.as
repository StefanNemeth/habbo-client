
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FavouriteMembershipUpdateMessageParser implements IMessageParser 
    {

        private var _roomIndex:int;
        private var _habboGroupId:int;
        private var _status:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._roomIndex = _arg_1.readInteger();
            this._habboGroupId = _arg_1.readInteger();
            this._status = _arg_1.readInteger();
            return (true);
        }
        public function get roomIndex():int
        {
            return (this._roomIndex);
        }
        public function get habboGroupId():int
        {
            return (this._habboGroupId);
        }
        public function get status():int
        {
            return (this._status);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FavouriteMembershipUpdateMessageParser = "_-0I" (String#3916, DoABC#2)
// _roomIndex = "_-1S2" (String#362, DoABC#2)
// _habboGroupId = "_-2IT" (String#6412, DoABC#2)
// _status = "_-0kS" (String#126, DoABC#2)
// habboGroupId = "_-PC" (String#23215, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


