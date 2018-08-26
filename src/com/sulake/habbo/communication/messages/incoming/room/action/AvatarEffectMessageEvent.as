
package com.sulake.habbo.communication.messages.incoming.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.AvatarEffectMessageParser;

    public class AvatarEffectMessageEvent extends MessageEvent 
    {

        public function AvatarEffectMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvatarEffectMessageParser);
        }
        public function getParser():AvatarEffectMessageParser
        {
            return ((_parser as AvatarEffectMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.action

// AvatarEffectMessageEvent = "_-1Cw" (String#16979, DoABC#2)
// AvatarEffectMessageParser = "_-17O" (String#5023, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


