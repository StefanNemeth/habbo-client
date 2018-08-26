
package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class BadgePointLimitsParser implements IMessageParser 
    {

        private var _data:Array;

        public function flush():Boolean
        {
            this._data = new Array();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:String;
            var _local_5:int;
            var _local_6:int;
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1.readString();
                _local_5 = _arg_1.readInteger();
                _local_6 = 0;
                while (_local_6 < _local_5) {
                    this._data.push(new BadgeAndPointLimit(_local_4, _arg_1));
                    _local_6++;
                };
                _local_3++;
            };
            return (true);
        }
        public function get data():Array
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.badges

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// BadgePointLimitsParser = "_-2ak" (String#20477, DoABC#2)
// BadgeAndPointLimit = "_-2-t" (String#19006, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


