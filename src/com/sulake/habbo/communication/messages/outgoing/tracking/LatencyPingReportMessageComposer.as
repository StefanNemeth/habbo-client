
package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class LatencyPingReportMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_4818:int;
        private var _SafeStr_4819:int;
        private var _SafeStr_4820:int;

        public function LatencyPingReportMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            this._SafeStr_4818 = _arg_1;
            this._SafeStr_4819 = _arg_2;
            this._SafeStr_4820 = _arg_3;
        }
        public function getMessageArray():Array
        {
            return ([this._SafeStr_4818, this._SafeStr_4819, this._SafeStr_4820]);
        }
        public function dispose():void
        {
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.tracking

// LatencyPingReportMessageComposer = "_-0Bk" (String#3790, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_4818 = "_-142" (String#16618, DoABC#2)
// _SafeStr_4819 = "_-0XE" (String#15324, DoABC#2)
// _SafeStr_4820 = "_-2zc" (String#21444, DoABC#2)


