
package com.sulake.habbo.friendbar.utils
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.core.communication.util.Short;

    public class TestMessageWrapper implements IMessageDataWrapper 
    {

        private var _data:Array;

        public function TestMessageWrapper(_arg_1:Array)
        {
            this._data = _arg_1;
            this._data.reverse();
        }
        public function readString():String
        {
            return (String(this._data.pop()));
        }
        public function readInteger():int
        {
            return (int(this._data.pop()));
        }
        public function readBoolean():Boolean
        {
            return (Boolean(this._data.pop()));
        }
        public function readShort():Short
        {
            return (Short(this._data.pop()));
        }

    }
}//package com.sulake.habbo.friendbar.utils

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// TestMessageWrapper = "_-1Bc" (String#16924, DoABC#2)
// Short = "_-0S7" (String#4139, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)


