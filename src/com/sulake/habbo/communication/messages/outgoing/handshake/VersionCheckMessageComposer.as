
package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class VersionCheckMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_4602:int;
        private var _SafeStr_4603:String;
        private var _SafeStr_4604:String;

        public function VersionCheckMessageComposer(_arg_1:int, _arg_2:String, _arg_3:String)
        {
            this._SafeStr_4602 = _arg_1;
            this._SafeStr_4603 = _arg_2;
            this._SafeStr_4604 = _arg_3;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._SafeStr_4602, this._SafeStr_4603, this._SafeStr_4604]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.handshake

// VersionCheckMessageComposer = "_-0ou" (String#4613, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_4602 = "_-nv" (String#24187, DoABC#2)
// _SafeStr_4603 = "_-2QQ" (String#6569, DoABC#2)
// _SafeStr_4604 = "_-1t5" (String#18680, DoABC#2)


