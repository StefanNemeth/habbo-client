
package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UniqueMachineIDParser;

    public class UniqueMachineIDEvent extends MessageEvent implements IMessageEvent 
    {

        public function UniqueMachineIDEvent(_arg_1:Function)
        {
            super(_arg_1, UniqueMachineIDParser);
        }
        private function getParser():UniqueMachineIDParser
        {
            return ((this._parser as UniqueMachineIDParser));
        }
        public function get machineID():String
        {
            return (this.getParser().machineID);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.handshake

// UniqueMachineIDEvent = "_-0xp" (String#4804, DoABC#2)
// UniqueMachineIDParser = "_-yY" (String#8847, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// machineID = "_-08r" (String#14399, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


