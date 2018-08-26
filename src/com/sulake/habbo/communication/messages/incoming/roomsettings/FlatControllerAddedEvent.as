
package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerAddedMessageParser;

    public class FlatControllerAddedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatControllerAddedEvent(_arg_1:Function)
        {
            super(_arg_1, FlatControllerAddedMessageParser);
        }
        public function getParser():FlatControllerAddedMessageParser
        {
            return ((this._parser as FlatControllerAddedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.roomsettings

// FlatControllerAddedEvent = "_-24H" (String#19188, DoABC#2)
// FlatControllerAddedMessageParser = "_-0zG" (String#4832, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


