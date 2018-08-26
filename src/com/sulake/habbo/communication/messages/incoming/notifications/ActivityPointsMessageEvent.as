
package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.ActivityPointsMessageParser;
    import flash.utils.Dictionary;

    public class ActivityPointsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ActivityPointsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ActivityPointsMessageParser);
        }
        public function get points():Dictionary
        {
            return ((_parser as ActivityPointsMessageParser).points);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.notifications

// ActivityPointsMessageEvent = "_-0Fl" (String#14673, DoABC#2)
// ActivityPointsMessageParser = "_-0E9" (String#3830, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


