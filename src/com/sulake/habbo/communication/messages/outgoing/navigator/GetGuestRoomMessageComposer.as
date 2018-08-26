
package com.sulake.habbo.communication.messages.outgoing.navigator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetGuestRoomMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_3708:Array;

        public function GetGuestRoomMessageComposer(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean)
        {
            this._SafeStr_3708 = new Array();
            super();
            this._SafeStr_3708.push(_arg_1);
            this._SafeStr_3708.push(((_arg_2) ? 1 : 0));
            this._SafeStr_3708.push(((_arg_3) ? 1 : 0));
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
}//package com.sulake.habbo.communication.messages.outgoing.navigator

// GetGuestRoomMessageComposer = "_-0va" (String#16260, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_3708 = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


