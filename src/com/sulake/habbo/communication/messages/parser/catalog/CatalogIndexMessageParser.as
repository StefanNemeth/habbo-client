
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogIndexMessageParser implements IMessageParser 
    {

        private var _root:NodeData;
        private var _newAdditionsAvailable:Boolean;

        public function get root():NodeData
        {
            return (this._root);
        }
        public function get newAdditionsAvailable():Boolean
        {
            return (this._newAdditionsAvailable);
        }
        public function flush():Boolean
        {
            this._root = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._root = new NodeData(_arg_1);
            this._newAdditionsAvailable = _arg_1.readBoolean();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// _newAdditionsAvailable = "_-1Tn" (String#5428, DoABC#2)
// NodeData = "_-02P" (String#3615, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// CatalogIndexMessageParser = "_-2bs" (String#6792, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// newAdditionsAvailable = "_-2p" (String#21040, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


