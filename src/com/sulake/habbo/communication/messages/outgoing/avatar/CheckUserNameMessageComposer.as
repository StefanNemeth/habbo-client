
package com.sulake.habbo.communication.messages.outgoing.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class CheckUserNameMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function CheckUserNameMessageComposer(_arg_1:String)
        {
            this._data = new Array();
            this._data.push(_arg_1);
        }
        public function getMessageArray():Array
        {
            return (this._data);
        }
        public function dispose():void
        {
            this._data = null;
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.avatar

// CheckUserNameMessageComposer = "_-pJ" (String#24245, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


