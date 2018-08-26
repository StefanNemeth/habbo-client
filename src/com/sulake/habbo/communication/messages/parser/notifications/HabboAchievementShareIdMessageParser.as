
package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboAchievementShareIdMessageParser implements IMessageParser 
    {

        private var _badgeID:String = "";
        private var _shareID:String = "";

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._badgeID = _arg_1.readString();
            this._shareID = _arg_1.readString();
            return (true);
        }
        public function get badgeID():String
        {
            return (this._badgeID);
        }
        public function get shareID():String
        {
            return (this._shareID);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.notifications

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HabboAchievementShareIdMessageParser = "_-ju" (String#8599, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// badgeID = "_-Cm" (String#22716, DoABC#2)
// shareID = "_-02x" (String#14159, DoABC#2)
// _badgeID = "_-1Vx" (String#5471, DoABC#2)
// _shareID = "_-1v6" (String#18760, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


