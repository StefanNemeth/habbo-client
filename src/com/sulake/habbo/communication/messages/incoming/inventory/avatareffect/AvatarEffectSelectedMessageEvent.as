
package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectSelectedMessageParser;

    public class AvatarEffectSelectedMessageEvent extends MessageEvent 
    {

        public function AvatarEffectSelectedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvatarEffectSelectedMessageParser);
        }
        public function getParser():AvatarEffectSelectedMessageParser
        {
            return ((_parser as AvatarEffectSelectedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect

// AvatarEffectSelectedMessageEvent = "_-0Dy" (String#14605, DoABC#2)
// AvatarEffectSelectedMessageParser = "_-0Ff" (String#3865, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


