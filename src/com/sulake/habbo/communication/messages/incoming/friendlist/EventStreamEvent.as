
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.EventStreamMessageParser;
    import __AS3__.vec.Vector;

    public class EventStreamEvent extends MessageEvent implements IMessageEvent 
    {

        public function EventStreamEvent(_arg_1:Function)
        {
            super(_arg_1, EventStreamMessageParser);
        }
        public function get events():Vector.<EventStreamData>
        {
            return (EventStreamMessageParser(_parser).events);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// EventStreamEvent = "_-0fC" (String#15637, DoABC#2)
// EventStreamMessageParser = "_-g0" (String#8512, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


