
package com.sulake.habbo.communication.messages.outgoing.marketplace
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class MakeOfferMessageComposer implements IMessageComposer, IDisposable 
    {

        public static const _SafeStr_8598:int = 1;
        public static const _SafeStr_8599:int = 2;

        private var _SafeStr_3708:Array;

        public function MakeOfferMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            this._SafeStr_3708 = new Array();
            super();
            this._SafeStr_3708.push(_arg_1);
            this._SafeStr_3708.push(_arg_2);
            this._SafeStr_3708.push(_arg_3);
        }
        public function getMessageArray():Array
        {
            return (this._SafeStr_3708);
        }
        public function dispose():void
        {
            this._SafeStr_3708 = null;
        }
        public function get disposed():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.marketplace

// MakeOfferMessageComposer = "_-0pb" (String#16038, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_3708 = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_8598 = "_-2So" (String#20152, DoABC#2)
// _SafeStr_8599 = "_-1vT" (String#18776, DoABC#2)


