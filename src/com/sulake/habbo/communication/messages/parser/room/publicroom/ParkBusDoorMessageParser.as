
package com.sulake.habbo.communication.messages.parser.room.publicroom
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ParkBusDoorMessageParser implements IMessageParser 
    {

        private var _status:int;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get status():int
        {
            return (this._status);
        }
        public function flush():Boolean
        {
            this._status = 0;
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._status = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.publicroom

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ParkBusDoorMessageParser = "_-1pC" (String#5843, DoABC#2)
// _status = "_-0kS" (String#126, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


