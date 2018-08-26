
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.GiftWrappingConfigurationParser;

    public class GiftWrappingConfigurationEvent extends MessageEvent implements IMessageEvent 
    {

        public function GiftWrappingConfigurationEvent(_arg_1:Function)
        {
            super(_arg_1, GiftWrappingConfigurationParser);
        }
        public function getParser():GiftWrappingConfigurationParser
        {
            return ((this._parser as GiftWrappingConfigurationParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// GiftWrappingConfigurationEvent = "_-1tN" (String#18692, DoABC#2)
// GiftWrappingConfigurationParser = "_-a2" (String#8422, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


