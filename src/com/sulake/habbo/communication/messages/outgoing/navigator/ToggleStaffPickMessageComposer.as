
package com.sulake.habbo.communication.messages.outgoing.navigator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class ToggleStaffPickMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _messageArray:Array;

        public function ToggleStaffPickMessageComposer(_arg_1:int, _arg_2:Boolean)
        {
            this._messageArray = new Array();
            super();
            this._messageArray.push(_arg_1);
            this._messageArray.push(_arg_2);
        }
        public function getMessageArray():Array
        {
            return (this._messageArray);
        }
        public function dispose():void
        {
            this._messageArray = null;
        }
        public function get disposed():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.navigator

// ToggleStaffPickMessageComposer = "_-2Rb" (String#20103, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _messageArray = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


