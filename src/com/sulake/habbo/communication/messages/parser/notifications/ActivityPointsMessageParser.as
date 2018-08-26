
package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import flash.utils.Dictionary;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ActivityPointsMessageParser implements IMessageParser 
    {

        private var _points:Dictionary;

        public function flush():Boolean
        {
            this._points = new Dictionary();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_5:int;
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readInteger();
                this._points[_local_4] = _local_5;
                _local_3++;
            };
            return (true);
        }
        public function get points():Dictionary
        {
            return (this._points);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.notifications

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ActivityPointsMessageParser = "_-0E9" (String#3830, DoABC#2)
// _points = "_-3-6" (String#7288, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


