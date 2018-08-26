
package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class UpdateConditionMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_3708:Array;

        public function UpdateConditionMessageComposer(_arg_1:int, _arg_2:Array, _arg_3:String, _arg_4:Array, _arg_5:int)
        {
            var _local_6:int;
            this._SafeStr_3708 = new Array();
            super();
            this._SafeStr_3708.push(_arg_1);
            this._SafeStr_3708.push(_arg_2.length);
            for each (_local_6 in _arg_2) {
                this._SafeStr_3708.push(_local_6);
            };
            this._SafeStr_3708.push(_arg_3);
            this._SafeStr_3708.push(_arg_4.length);
            for each (_arg_1 in _arg_4) {
                this._SafeStr_3708.push(_arg_1);
            };
            this._SafeStr_3708.push(_arg_5);
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
}//package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents

// UpdateConditionMessageComposer = "_-0Et" (String#14639, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_3708 = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


