
package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniConditionMessageParser;

    public class WiredFurniConditionEvent extends MessageEvent implements IMessageEvent 
    {

        public function WiredFurniConditionEvent(_arg_1:Function)
        {
            super(_arg_1, WiredFurniConditionMessageParser);
        }
        public function getParser():WiredFurniConditionMessageParser
        {
            return ((this._parser as WiredFurniConditionMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents

// WiredFurniConditionMessageParser = "_-2a5" (String#6761, DoABC#2)
// WiredFurniConditionEvent = "_-33a" (String#21645, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


