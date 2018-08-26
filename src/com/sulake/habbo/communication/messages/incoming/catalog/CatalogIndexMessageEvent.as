
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.CatalogIndexMessageParser;

    public class CatalogIndexMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CatalogIndexMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CatalogIndexMessageParser);
        }
        public function getParser():CatalogIndexMessageParser
        {
            return ((this._parser as CatalogIndexMessageParser));
        }
        public function get root():NodeData
        {
            return ((_parser as CatalogIndexMessageParser).root);
        }
        public function get newAdditionsAvailable():Boolean
        {
            return ((_parser as CatalogIndexMessageParser).newAdditionsAvailable);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// NodeData = "_-02P" (String#3615, DoABC#2)
// CatalogIndexMessageEvent = "_-Xi" (String#23550, DoABC#2)
// CatalogIndexMessageParser = "_-2bs" (String#6792, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// newAdditionsAvailable = "_-2p" (String#21040, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


