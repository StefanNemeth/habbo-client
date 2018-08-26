
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.CatalogPageMessageParser;

    public class CatalogPageMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CatalogPageMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CatalogPageMessageParser);
        }
        public function getParser():CatalogPageMessageParser
        {
            return ((this._parser as CatalogPageMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// CatalogPageMessageEvent = "_-31o" (String#21570, DoABC#2)
// CatalogPageMessageParser = "_-1gI" (String#5668, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


