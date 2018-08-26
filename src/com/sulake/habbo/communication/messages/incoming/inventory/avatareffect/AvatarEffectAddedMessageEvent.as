
package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectAddedMessageParser;

    public class AvatarEffectAddedMessageEvent extends MessageEvent 
    {

        public function AvatarEffectAddedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvatarEffectAddedMessageParser);
        }
        public function getParser():AvatarEffectAddedMessageParser
        {
            return ((_parser as AvatarEffectAddedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect

// AvatarEffectAddedMessageParser = "_-317" (String#21543, DoABC#2)
// AvatarEffectAddedMessageEvent = "_-MW" (String#8132, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


