
package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniTriggerMessageParser;

    public class WiredFurniTriggerEvent extends MessageEvent implements IMessageEvent 
    {

        public function WiredFurniTriggerEvent(_arg_1:Function)
        {
            super(_arg_1, WiredFurniTriggerMessageParser);
        }
        public function getParser():WiredFurniTriggerMessageParser
        {
            return ((this._parser as WiredFurniTriggerMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents

// WiredFurniTriggerMessageParser = "_-0yP" (String#4817, DoABC#2)
// WiredFurniTriggerEvent = "_-1lj" (String#18363, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


