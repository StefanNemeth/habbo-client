
package com.sulake.habbo.catalog.purchase
{
    import com.sulake.habbo.communication.messages.parser.catalog.GiftWrappingConfigurationParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;

    public class GiftWrappingConfiguration 
    {

        private var _isEnabled:Boolean = false;
        private var _price:int;
        private var _stuffTypes:Array;
        private var _boxTypes:Array;
        private var _ribbonTypes:Array;

        public function GiftWrappingConfiguration(_arg_1:GiftWrappingConfigurationEvent)
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:GiftWrappingConfigurationParser = _arg_1.getParser();
            if (_local_2 == null){
                return;
            };
            this._isEnabled = _local_2.isWrappingEnabled;
            this._price = _local_2.wrappingPrice;
            this._stuffTypes = _local_2.stuffTypes;
            this._boxTypes = _local_2.boxTypes;
            this._ribbonTypes = _local_2.ribbonTypes;
        }
        public function get isEnabled():Boolean
        {
            return (this._isEnabled);
        }
        public function get price():int
        {
            return (this._price);
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

    }
}//package com.sulake.habbo.catalog.purchase

// GiftWrappingConfigurationEvent = "_-1tN" (String#18692, DoABC#2)
// GiftWrappingConfiguration = "_-0BE" (String#14495, DoABC#2)
// GiftWrappingConfigurationParser = "_-a2" (String#8422, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// _price = "_-35-" (String#631, DoABC#2)
// _stuffTypes = "_-ya" (String#2230, DoABC#2)
// _ribbonTypes = "_-1RU" (String#1685, DoABC#2)
// _boxTypes = "_-2Pq" (String#1874, DoABC#2)
// isEnabled = "_-2ri" (String#21145, DoABC#2)
// stuffTypes = "_-1BP" (String#16914, DoABC#2)
// boxTypes = "_-P9" (String#23213, DoABC#2)
// ribbonTypes = "_-28J" (String#19343, DoABC#2)
// _isEnabled = "_-2au" (String#895, DoABC#2)
// isWrappingEnabled = "_-0mk" (String#15927, DoABC#2)
// wrappingPrice = "_-09x" (String#14445, DoABC#2)


