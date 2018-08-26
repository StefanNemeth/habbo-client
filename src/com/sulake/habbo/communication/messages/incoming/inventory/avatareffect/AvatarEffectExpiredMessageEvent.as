
package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectExpiredMessageParser;

    public class AvatarEffectExpiredMessageEvent extends MessageEvent 
    {

        public function AvatarEffectExpiredMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvatarEffectExpiredMessageParser);
        }
        public function getParser():AvatarEffectExpiredMessageParser
        {
            return ((_parser as AvatarEffectExpiredMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect

// AvatarEffectExpiredMessageEvent = "_-0Sv" (String#4158, DoABC#2)
// AvatarEffectExpiredMessageParser = "_-0bx" (String#15509, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


