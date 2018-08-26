
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OffenceData implements INamed 
    {

        private var _name:String;
        private var _msg:String;

        public function OffenceData(_arg_1:IMessageDataWrapper)
        {
            this._name = _arg_1.readString();
            this._msg = _arg_1.readString();
            Logger.log(((("READ OFF: " + this._name) + ", ") + this._msg));
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get msg():String
        {
            return (this._msg);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// INamed = "_-11E" (String#4899, DoABC#2)
// OffenceData = "_-10e" (String#4886, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _msg = "_-Zx" (String#937, DoABC#2)
// msg = "_-1Bo" (String#16933, DoABC#2)


