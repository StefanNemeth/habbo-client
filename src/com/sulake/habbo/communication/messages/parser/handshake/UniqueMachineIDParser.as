
package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UniqueMachineIDParser implements IMessageParser 
    {

        private var _machineID:String;

        public function UniqueMachineIDParser()
        {
            this._machineID = "";
        }
        public function flush():Boolean
        {
            this._machineID = "";
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._machineID = _arg_1.readString();
            return (true);
        }
        public function get machineID():String
        {
            return (this._machineID);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.handshake

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// UniqueMachineIDParser = "_-yY" (String#8847, DoABC#2)
// machineID = "_-08r" (String#14399, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _machineID = "_-0Z1" (String#4280, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


