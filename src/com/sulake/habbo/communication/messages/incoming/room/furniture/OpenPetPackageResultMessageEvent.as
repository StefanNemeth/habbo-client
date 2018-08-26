
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageResultMessageParser;

    public class OpenPetPackageResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function OpenPetPackageResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, OpenPetPackageResultMessageParser);
        }
        public function getParser():OpenPetPackageResultMessageParser
        {
            return ((_parser as OpenPetPackageResultMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// OpenPetPackageResultMessageEvent = "_-1Ob" (String#17453, DoABC#2)
// OpenPetPackageResultMessageParser = "_-09b" (String#3750, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


