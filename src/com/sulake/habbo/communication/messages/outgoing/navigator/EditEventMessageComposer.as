
package com.sulake.habbo.communication.messages.outgoing.navigator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class EditEventMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _messageArray:Array;

        public function EditEventMessageComposer(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:Array)
        {
            var _local_5:String;
            this._messageArray = new Array();
            super();
            this._messageArray.push(_arg_1);
            this._messageArray.push(_arg_2);
            this._messageArray.push(_arg_3);
            this._messageArray.push(_arg_4.length);
            for each (_local_5 in _arg_4) {
                this._messageArray.push(_local_5);
            };
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

// EditEventMessageComposer = "_-1sL" (String#18646, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _messageArray = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


