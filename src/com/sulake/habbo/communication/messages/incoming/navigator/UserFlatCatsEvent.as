
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.UserFlatCatsMessageParser;

    public class UserFlatCatsEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserFlatCatsEvent(_arg_1:Function)
        {
            super(_arg_1, UserFlatCatsMessageParser);
        }
        public function getParser():UserFlatCatsMessageParser
        {
            return ((this._parser as UserFlatCatsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// UserFlatCatsEvent = "_-eB" (String#23810, DoABC#2)
// UserFlatCatsMessageParser = "_-FJ" (String#7976, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


