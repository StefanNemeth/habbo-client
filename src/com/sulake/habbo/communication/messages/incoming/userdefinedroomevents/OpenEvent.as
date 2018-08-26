
package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.OpenMessageParser;

    public class OpenEvent extends MessageEvent implements IMessageEvent 
    {

        public function OpenEvent(_arg_1:Function)
        {
            super(_arg_1, OpenMessageParser);
        }
        public function getParser():OpenMessageParser
        {
            return ((this._parser as OpenMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents

// OpenEvent = "_-0eW" (String#15607, DoABC#2)
// OpenMessageParser = "_-m5" (String#8645, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


