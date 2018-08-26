
package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PresentOpenedMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _itemType:String;
        private var _classId:int;
        private var _productCode:String;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get itemType():String
        {
            return (this._itemType);
        }
        public function get classId():int
        {
            return (this._classId);
        }
        public function get productCode():String
        {
            return (this._productCode);
        }
        public function flush():Boolean
        {
            this._itemType = "";
            this._classId = 0;
            this._productCode = "";
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._itemType = _arg_1.readString();
            this._classId = _arg_1.readInteger();
            this._productCode = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.furniture

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PresentOpenedMessageParser = "_-25F" (String#6147, DoABC#2)
// _itemType = "_-0dA" (String#242, DoABC#2)
// _classId = "_-172" (String#597, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// classId = "_-1mV" (String#18401, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _productCode = "_-uv" (String#312, DoABC#2)
// productCode = "_-2co" (String#20558, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


