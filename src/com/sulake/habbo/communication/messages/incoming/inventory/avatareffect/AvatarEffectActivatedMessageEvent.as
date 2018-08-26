
package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectActivatedMessageParser;

    public class AvatarEffectActivatedMessageEvent extends MessageEvent 
    {

        public function AvatarEffectActivatedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvatarEffectActivatedMessageParser);
        }
        public function getParser():AvatarEffectActivatedMessageParser
        {
            return ((_parser as AvatarEffectActivatedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect

// AvatarEffectActivatedMessageParser = "_-Mc" (String#23109, DoABC#2)
// AvatarEffectActivatedMessageEvent = "_-fk" (String#8508, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


