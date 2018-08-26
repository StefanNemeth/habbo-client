
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GiftWrappingConfigurationParser implements IMessageParser 
    {

        private var _isWrappingEnabled:Boolean;
        private var _wrappingPrice:int;
        private var _stuffTypes:Array;
        private var _boxTypes:Array;
        private var _ribbonTypes:Array;

        public function get isWrappingEnabled():Boolean
        {
            return (this._isWrappingEnabled);
        }
        public function get wrappingPrice():int
        {
            return (this._wrappingPrice);
        }
        public function get stuffTypes():Array
        {
            return (this._stuffTypes);
        }
        public function get boxTypes():Array
        {
            return (this._boxTypes);
        }
        public function get ribbonTypes():Array
        {
            return (this._ribbonTypes);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            this._stuffTypes = [];
            this._boxTypes = [];
            this._ribbonTypes = [];
            this._isWrappingEnabled = _arg_1.readBoolean();
            this._wrappingPrice = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3) {
                this._stuffTypes.push(_arg_1.readInteger());
                _local_2++;
            };
            _local_3 = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3) {
                this._boxTypes.push(_arg_1.readInteger());
                _local_2++;
            };
            _local_3 = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3) {
                this._ribbonTypes.push(_arg_1.readInteger());
                _local_2++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// _isWrappingEnabled = "_-0SH" (String#15145, DoABC#2)
// _wrappingPrice = "_-1sO" (String#18648, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// GiftWrappingConfigurationParser = "_-a2" (String#8422, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _stuffTypes = "_-ya" (String#2230, DoABC#2)
// _ribbonTypes = "_-1RU" (String#1685, DoABC#2)
// _boxTypes = "_-2Pq" (String#1874, DoABC#2)
// stuffTypes = "_-1BP" (String#16914, DoABC#2)
// boxTypes = "_-P9" (String#23213, DoABC#2)
// ribbonTypes = "_-28J" (String#19343, DoABC#2)
// isWrappingEnabled = "_-0mk" (String#15927, DoABC#2)
// wrappingPrice = "_-09x" (String#14445, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


