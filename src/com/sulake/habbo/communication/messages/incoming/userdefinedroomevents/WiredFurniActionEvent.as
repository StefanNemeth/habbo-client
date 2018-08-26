
package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniActionMessageParser;

    public class WiredFurniActionEvent extends MessageEvent implements IMessageEvent 
    {

        public function WiredFurniActionEvent(_arg_1:Function)
        {
            super(_arg_1, WiredFurniActionMessageParser);
        }
        public function getParser():WiredFurniActionMessageParser
        {
            return ((this._parser as WiredFurniActionMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents

// WiredFurniActionMessageParser = "_-35K" (String#7414, DoABC#2)
// WiredFurniActionEvent = "_-2-d" (String#18997, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


