
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChatlineData 
    {

        private var _hour:int;
        private var _minute:int;
        private var _chatterId:int;
        private var _chatterName:String;
        private var _msg:String;

        public function ChatlineData(_arg_1:IMessageDataWrapper)
        {
            this._hour = _arg_1.readInteger();
            this._minute = _arg_1.readInteger();
            this._chatterId = _arg_1.readInteger();
            this._chatterName = _arg_1.readString();
            this._msg = _arg_1.readString();
        }
        public function get hour():int
        {
            return (this._hour);
        }
        public function get minute():int
        {
            return (this._minute);
        }
        public function get chatterId():int
        {
            return (this._chatterId);
        }
        public function get chatterName():String
        {
            return (this._chatterName);
        }
        public function get msg():String
        {
            return (this._msg);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ChatlineData = "_-0ap" (String#4320, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _msg = "_-Zx" (String#937, DoABC#2)
// _hour = "_-0U" (String#15205, DoABC#2)
// _minute = "_-2I3" (String#19730, DoABC#2)
// _chatterId = "_-0up" (String#16231, DoABC#2)
// _chatterName = "_-kM" (String#24048, DoABC#2)
// hour = "_-20F" (String#19022, DoABC#2)
// minute = "_-4w" (String#22416, DoABC#2)
// chatterId = "_-VR" (String#23469, DoABC#2)
// chatterName = "_-2MC" (String#19893, DoABC#2)
// msg = "_-1Bo" (String#16933, DoABC#2)


