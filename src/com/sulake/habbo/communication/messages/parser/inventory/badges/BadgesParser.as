
package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class BadgesParser implements IMessageParser 
    {

        private var _SafeStr_8220:Array;
        private var _SafeStr_8221:Array;
        private var _SafeStr_8222:Map;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_3:String;
            var _local_8:int;
            this._SafeStr_8220 = new Array();
            this._SafeStr_8222 = new Map();
            var _local_4:int = _arg_1.readInteger();
            var _local_5:int;
            while (_local_5 < _local_4) {
                _local_2 = _arg_1.readInteger();
                _local_3 = _arg_1.readString();
                this._SafeStr_8222.add(_local_3, _local_2);
                this._SafeStr_8220.push(_local_3);
                _local_5++;
            };
            this._SafeStr_8221 = new Array();
            var _local_6:int = _arg_1.readInteger();
            var _local_7:int;
            while (_local_7 < _local_6) {
                _local_8 = _arg_1.readInteger();
                _local_3 = _arg_1.readString();
                this._SafeStr_8221.push(_local_3);
                _local_7++;
            };
            return (true);
        }
        public function getBadgeId(_arg_1:String):int
        {
            return (this._SafeStr_8222.getValue(_arg_1));
        }
        public function getAllBadgeCodes():Array
        {
            return (this._SafeStr_8220);
        }
        public function getActiveBadgeCodes():Array
        {
            return (this._SafeStr_8221);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.badges

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// BadgesParser = "_-14Z" (String#16638, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _SafeStr_8220 = "_-zG" (String#24663, DoABC#2)
// _SafeStr_8221 = "_-39c" (String#21866, DoABC#2)
// _SafeStr_8222 = "_-1SR" (String#5405, DoABC#2)
// getBadgeId = "_-Jj" (String#22995, DoABC#2)
// getAllBadgeCodes = "_-0eP" (String#15603, DoABC#2)
// getActiveBadgeCodes = "_-2pI" (String#21050, DoABC#2)


