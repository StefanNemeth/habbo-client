
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.UserTagsMessageParser;

    public class UserTagsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserTagsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserTagsMessageParser);
        }
        public function get tags():Array
        {
            return ((_parser as UserTagsMessageParser).tags);
        }
        public function get userId():int
        {
            return ((_parser as UserTagsMessageParser).userId);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// UserTagsMessageEvent = "_-04R" (String#3653, DoABC#2)
// UserTagsMessageParser = "_-11M" (String#4902, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


