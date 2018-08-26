
package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetUserTagsMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_3708:Array;

        public function GetUserTagsMessageComposer(_arg_1:int)
        {
            this._SafeStr_3708 = [];
            super();
            this._SafeStr_3708.push(int(_arg_1));
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
}//package com.sulake.habbo.communication.messages.outgoing.users

// GetUserTagsMessageComposer = "_-0tf" (String#16188, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_3708 = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


