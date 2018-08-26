
package com.sulake.habbo.communication.messages.outgoing.facebook
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class FaceBookIsLoggedOnMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_6969:Array;

        public function FaceBookIsLoggedOnMessageComposer(_arg_1:String, _arg_2:String, _arg_3:String)
        {
            this._SafeStr_6969 = [_arg_1, _arg_2, _arg_3];
        }
        public function getMessageArray():Array
        {
            return (this._SafeStr_6969);
        }
        public function dispose():void
        {
            this._SafeStr_6969 = null;
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.facebook

// FaceBookIsLoggedOnMessageComposer = "_-0ov" (String#16008, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_6969 = "_-0uz" (String#1576, DoABC#2)


