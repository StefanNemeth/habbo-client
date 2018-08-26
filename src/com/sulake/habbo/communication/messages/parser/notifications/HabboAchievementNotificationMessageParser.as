
package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.notifications.AchievementLevelUpData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboAchievementNotificationMessageParser implements IMessageParser 
    {

        private var _data:AchievementLevelUpData;

        public function flush():Boolean
        {
            this._data = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new AchievementLevelUpData(_arg_1);
            return (true);
        }
        public function get data():AchievementLevelUpData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.notifications

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AchievementLevelUpData = "_-1h6" (String#5687, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// HabboAchievementNotificationMessageParser = "_-Zs" (String#8418, DoABC#2)


