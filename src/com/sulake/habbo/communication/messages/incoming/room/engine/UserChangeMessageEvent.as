
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserChangeMessageParser;

    public class UserChangeMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserChangeMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserChangeMessageParser);
        }
        public function get roomId():int
        {
            return ((_parser as UserChangeMessageParser).roomId);
        }
        public function get roomCategory():int
        {
            return ((_parser as UserChangeMessageParser).roomCategory);
        }
        public function get id():int
        {
            return ((_parser as UserChangeMessageParser).id);
        }
        public function get figure():String
        {
            return ((_parser as UserChangeMessageParser).figure);
        }
        public function get sex():String
        {
            return ((_parser as UserChangeMessageParser).sex);
        }
        public function get customInfo():String
        {
            return ((_parser as UserChangeMessageParser).customInfo);
        }
        public function get achievementScore():int
        {
            return ((_parser as UserChangeMessageParser).achievementScore);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// UserChangeMessageEvent = "_-a9" (String#23638, DoABC#2)
// UserChangeMessageParser = "_-0M8" (String#4003, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// sex = "_-0tG" (String#4712, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)
// customInfo = "_-2Mk" (String#19916, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


