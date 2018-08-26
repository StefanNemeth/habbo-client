
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.PublicSpaceCastLibsMessageParser;

    public class PublicSpaceCastLibsEvent extends MessageEvent implements IMessageEvent 
    {

        public function PublicSpaceCastLibsEvent(_arg_1:Function)
        {
            super(_arg_1, PublicSpaceCastLibsMessageParser);
        }
        public function getParser():PublicSpaceCastLibsMessageParser
        {
            return ((this._parser as PublicSpaceCastLibsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// PublicSpaceCastLibsEvent = "_-ms" (String#24146, DoABC#2)
// PublicSpaceCastLibsMessageParser = "_-3Dk" (String#7592, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


