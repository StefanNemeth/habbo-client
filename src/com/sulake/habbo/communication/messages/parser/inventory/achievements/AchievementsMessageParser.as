
package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AchievementsMessageParser implements IMessageParser 
    {

        private var _achievements:Array;
        private var _defaultCategory:String;

        public function flush():Boolean
        {
            this._achievements = new Array();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._achievements = new Array();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._achievements.push(new AchievementData(_arg_1));
                _local_3++;
            };
            this._defaultCategory = _arg_1.readString();
            return (true);
        }
        public function get achievements():Array
        {
            return (this._achievements);
        }
        public function get defaultCategory():String
        {
            return (this._defaultCategory);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.achievements

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AchievementsMessageParser = "_-Rf" (String#8241, DoABC#2)
// AchievementData = "_-39C" (String#7494, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _defaultCategory = "_-2J9" (String#19773, DoABC#2)
// achievements = "_-2JC" (String#19776, DoABC#2)
// defaultCategory = "_-12L" (String#16551, DoABC#2)


