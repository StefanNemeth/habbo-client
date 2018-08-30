
package com.sulake.habbo.communication.messages.outgoing.marketplace
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetOffersMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _messageArray:Array;

        public function GetOffersMessageComposer(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int)
        {
            this._messageArray = new Array();
            super();
            this._messageArray.push(_arg_1);
            this._messageArray.push(_arg_2);
            this._messageArray.push(_arg_3);
            this._messageArray.push(_arg_4);
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
}//package com.sulake.habbo.communication.messages.outgoing.marketplace

// GetOffersMessageComposer = "_-1rt" (String#18626, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _messageArray = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


