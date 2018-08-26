
package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetEventStreamComposer implements IMessageComposer 
    {

        public static const _SafeStr_4509:int = 0;
        public static const _SafeStr_4510:int = 1;

        private var _param:int;

        public function GetEventStreamComposer(_arg_1:int=0)
        {
            this._param = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._param]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.friendlist

// GetEventStreamComposer = "_-01r" (String#14122, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _param = "_-2d3" (String#306, DoABC#2)
// _SafeStr_4509 = "_-2aC" (String#20450, DoABC#2)
// _SafeStr_4510 = "_-2n7" (String#20967, DoABC#2)


