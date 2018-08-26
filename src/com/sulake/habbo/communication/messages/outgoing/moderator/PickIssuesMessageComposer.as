
package com.sulake.habbo.communication.messages.outgoing.moderator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class PickIssuesMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_3708:Array;

        public function PickIssuesMessageComposer(_arg_1:Array, _arg_2:Boolean=false, _arg_3:int=0)
        {
            this._SafeStr_3708 = new Array();
            super();
            this._SafeStr_3708.push(_arg_1.length);
            var _local_4:int;
            while (_local_4 < _arg_1.length) {
                this._SafeStr_3708.push(_arg_1[_local_4]);
                _local_4++;
            };
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
}//package com.sulake.habbo.communication.messages.outgoing.moderator

// PickIssuesMessageComposer = "_-0iu" (String#15787, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_3708 = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


