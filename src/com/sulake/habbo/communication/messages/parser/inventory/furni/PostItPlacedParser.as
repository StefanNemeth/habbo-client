
package com.sulake.habbo.communication.messages.parser.inventory.furni
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PostItPlacedParser implements IMessageParser 
    {

        private var _id:int;
        private var _itemsLeft:int;

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._id = _arg_1.readInteger();
            this._itemsLeft = _arg_1.readInteger();
            return (true);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get itemsLeft():int
        {
            return (this._itemsLeft);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.furni

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PostItPlacedParser = "_-10u" (String#16494, DoABC#2)
// _itemsLeft = "_-1Zr" (String#17884, DoABC#2)
// itemsLeft = "_-1Og" (String#17456, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


