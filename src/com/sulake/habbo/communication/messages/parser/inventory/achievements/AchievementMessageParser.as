
package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AchievementMessageParser implements IMessageParser 
    {

        private var _achievement:AchievementData;

        public function flush():Boolean
        {
            this._achievement = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._achievement = new AchievementData(_arg_1);
            return (true);
        }
        public function get achievement():AchievementData
        {
            return (this._achievement);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.achievements

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AchievementMessageParser = "_-fU" (String#8507, DoABC#2)
// AchievementData = "_-39C" (String#7494, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _achievement = "_-0zK" (String#4834, DoABC#2)


