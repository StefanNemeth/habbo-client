
package com.sulake.habbo.communication.messages.parser.room.publicroom
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ParkBusCannotEnterMessageParser implements IMessageParser 
    {

        private var _reason:String = "";

        public function get reason():String
        {
            return (this._reason);
        }
        public function flush():Boolean
        {
            this._reason = "";
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._reason = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.publicroom

// ParkBusCannotEnterMessageParser = "_-2iL" (String#6917, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// reason = "_-053" (String#14245, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _reason = "_-10m" (String#831, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


