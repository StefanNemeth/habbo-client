
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageRequestedMessageParser;

    public class OpenPetPackageRequestedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function OpenPetPackageRequestedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, OpenPetPackageRequestedMessageParser);
        }
        public function getParser():OpenPetPackageRequestedMessageParser
        {
            return ((_parser as OpenPetPackageRequestedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// OpenPetPackageRequestedMessageEvent = "_-1EY" (String#17050, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


