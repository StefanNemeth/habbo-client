
package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CarryObjectMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _userId:int = 0;
        private var _itemType:int;
        private var _itemName:String;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get itemType():int
        {
            return (this._itemType);
        }
        public function get itemName():String
        {
            return (this._itemName);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._userId = 0;
            this._itemType = 0;
            this._itemName = "";
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._userId = _arg_1.readInteger();
            this._itemType = _arg_1.readInteger();
            if (this._itemType > 0){
                this._itemName = _arg_1.readString();
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.action

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// CarryObjectMessageParser = "_-2TI" (String#6629, DoABC#2)
// _itemType = "_-0dA" (String#242, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _itemName = "_-IX" (String#8051, DoABC#2)
// itemName = "_-1cf" (String#17996, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


