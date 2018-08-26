
package com.sulake.habbo.communication.messages.parser.inventory.furni
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FurniListRemoveParser implements IMessageParser 
    {

        private var _itemId:int;

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._itemId = _arg_1.readInteger();
            return (true);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function get stripId():int
        {
            return (this._itemId);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.furni

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FurniListRemoveParser = "_-1Ep" (String#17062, DoABC#2)
// _itemId = "_-01C" (String#574, DoABC#2)
// stripId = "_-28E" (String#19340, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


