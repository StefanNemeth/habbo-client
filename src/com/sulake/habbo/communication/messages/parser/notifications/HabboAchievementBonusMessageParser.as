
package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboAchievementBonusMessageParser implements IMessageParser 
    {

        private var _bonusPoints:int;
        private var _realName:String;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._bonusPoints = _arg_1.readInteger();
            this._realName = _arg_1.readString();
            return (true);
        }
        public function get bonusPoints():int
        {
            return (this._bonusPoints);
        }
        public function get realName():String
        {
            return (this._realName);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.notifications

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HabboAchievementBonusMessageParser = "_-rm" (String#8732, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// bonusPoints = "_-0xr" (String#16347, DoABC#2)
// _bonusPoints = "_-yE" (String#8841, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


