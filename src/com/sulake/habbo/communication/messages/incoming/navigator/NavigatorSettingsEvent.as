
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.NavigatorSettingsMessageParser;

    public class NavigatorSettingsEvent extends MessageEvent implements IMessageEvent 
    {

        public function NavigatorSettingsEvent(_arg_1:Function)
        {
            super(_arg_1, NavigatorSettingsMessageParser);
        }
        public function getParser():NavigatorSettingsMessageParser
        {
            return ((this._parser as NavigatorSettingsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// NavigatorSettingsEvent = "_-3KS" (String#22302, DoABC#2)
// NavigatorSettingsMessageParser = "_-nt" (String#8676, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


