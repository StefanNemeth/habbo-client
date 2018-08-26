
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RoomMessageNotificationMessageParser;

    public class RoomMessageNotificationMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomMessageNotificationMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomMessageNotificationMessageParser);
        }
        public function getParser():RoomMessageNotificationMessageParser
        {
            return ((_parser as RoomMessageNotificationMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// RoomMessageNotificationMessageEvent = "_-0eE" (String#15596, DoABC#2)
// RoomMessageNotificationMessageParser = "_-1RL" (String#5382, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


