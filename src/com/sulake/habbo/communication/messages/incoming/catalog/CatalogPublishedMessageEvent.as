
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.CatalogPublishedMessageParser;

    public class CatalogPublishedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CatalogPublishedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CatalogPublishedMessageParser);
        }
        public function getParser():CatalogPublishedMessageParser
        {
            return ((this._parser as CatalogPublishedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// CatalogPublishedMessageEvent = "_-2Om" (String#19995, DoABC#2)
// CatalogPublishedMessageParser = "_-5I" (String#7767, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


