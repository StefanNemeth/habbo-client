
package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerRemovedMessageParser;

    public class FlatControllerRemovedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatControllerRemovedEvent(_arg_1:Function)
        {
            super(_arg_1, FlatControllerRemovedMessageParser);
        }
        public function getParser():FlatControllerRemovedMessageParser
        {
            return ((this._parser as FlatControllerRemovedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.roomsettings

// FlatControllerRemovedMessageParser = "_-00q" (String#3580, DoABC#2)
// FlatControllerRemovedEvent = "_-0ki" (String#15855, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


