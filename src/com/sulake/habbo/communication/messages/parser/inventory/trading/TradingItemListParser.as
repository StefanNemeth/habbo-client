
package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.ItemDataStructure;

    public class TradingItemListParser implements IMessageParser 
    {

        private var _firstUserID:int;
        private var _firstUserItemArray:Array;
        private var _secondUserID:int;
        private var _secondUserItemArray:Array;

        public function get firstUserID():int
        {
            return (this._firstUserID);
        }
        public function get firstUserItemArray():Array
        {
            return (this._firstUserItemArray);
        }
        public function get secondUserID():int
        {
            return (this._secondUserID);
        }
        public function get secondUserItemArray():Array
        {
            return (this._secondUserItemArray);
        }
        public function flush():Boolean
        {
            this._firstUserID = -1;
            this._firstUserItemArray = null;
            this._secondUserID = -1;
            this._secondUserItemArray = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._firstUserID = _arg_1.readInteger();
            this._firstUserItemArray = new Array();
            if (!this.parseItemData(_arg_1, this._firstUserItemArray)){
                return (false);
            };
            this._secondUserID = _arg_1.readInteger();
            this._secondUserItemArray = new Array();
            if (!this.parseItemData(_arg_1, this._secondUserItemArray)){
                return (false);
            };
            return (true);
        }
        private function parseItemData(_arg_1:IMessageDataWrapper, _arg_2:Array):Boolean
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:String;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:String;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:Boolean;
            var _local_15:int;
            _local_3 = _arg_1.readInteger();
            while (_local_3 > 0) {
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readString().toUpperCase();
                _local_6 = _arg_1.readInteger();
                _local_7 = _arg_1.readInteger();
                _local_8 = _arg_1.readInteger();
                _local_14 = _arg_1.readBoolean();
                _local_9 = _arg_1.readString();
                _local_10 = -1;
                _local_11 = _arg_1.readInteger();
                _local_12 = _arg_1.readInteger();
                _local_13 = _arg_1.readInteger();
                _local_15 = (((_local_5 == "S")) ? _arg_1.readInteger() : -1);
                _arg_2.push(new ItemDataStructure(_local_4, _local_5, _local_6, _local_7, _local_8, _local_9, _local_15, _local_10, _local_11, _local_12, _local_13, _local_14));
                _local_3--;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.trading

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ItemDataStructure = "_-2zB" (String#21429, DoABC#2)
// TradingItemListParser = "_-1R6" (String#17550, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// parseItemData = "_-34d" (String#7401, DoABC#2)
// firstUserID = "_-2QT" (String#20065, DoABC#2)
// secondUserID = "_-1i1" (String#18211, DoABC#2)
// firstUserItemArray = "_-1L1" (String#17314, DoABC#2)
// secondUserItemArray = "_-1KD" (String#17282, DoABC#2)
// _firstUserID = "_-2PI" (String#20013, DoABC#2)
// _secondUserID = "_-0pT" (String#16035, DoABC#2)
// _secondUserItemArray = "_-91" (String#22581, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


