
package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class LagWarningReportMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_4817:int;

        public function LagWarningReportMessageComposer(_arg_1:int)
        {
            this._SafeStr_4817 = _arg_1;
        }
        public function getMessageArray():Array
        {
            return ([this._SafeStr_4817]);
        }
        public function dispose():void
        {
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.tracking

// LagWarningReportMessageComposer = "_-p1" (String#8691, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_4817 = "_-2Et" (String#6340, DoABC#2)


