
package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class UpdateTriggerMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _messageArray:Array;

        public function UpdateTriggerMessageComposer(_arg_1:int, _arg_2:Array, _arg_3:String, _arg_4:Array, _arg_5:int)
        {
            var _local_6:int;
            this._messageArray = new Array();
            super();
            this._messageArray.push(_arg_1);
            this._messageArray.push(_arg_2.length);
            for each (_local_6 in _arg_2) {
                this._messageArray.push(_local_6);
            };
            this._messageArray.push(_arg_3);
            this._messageArray.push(_arg_4.length);
            for each (_arg_1 in _arg_4) {
                this._messageArray.push(_arg_1);
            };
            this._messageArray.push(_arg_5);
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
}//package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents

// UpdateTriggerMessageComposer = "_-Dg" (String#22757, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _messageArray = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


