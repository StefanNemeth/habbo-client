
package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectsMessageParser;

    public class AvatarEffectsMessageEvent extends MessageEvent 
    {

        public function AvatarEffectsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvatarEffectsMessageParser);
        }
        public function getParser():AvatarEffectsMessageParser
        {
            return ((_parser as AvatarEffectsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect

// AvatarEffectsMessageParser = "_-2m-" (String#20918, DoABC#2)
// AvatarEffectsMessageEvent = "_-2SA" (String#6610, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


