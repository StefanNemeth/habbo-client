
package com.sulake.habbo.quest
{
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;

    public class AchievementCategory 
    {

        private var _code:String;
        private var _achievements:Array;

        public function AchievementCategory(_arg_1:String)
        {
            this._achievements = new Array();
            super();
            this._code = _arg_1;
        }
        public function add(_arg_1:AchievementData):void
        {
            this._achievements.push(_arg_1);
        }
        public function update(_arg_1:AchievementData):void
        {
            var _local_3:AchievementData;
            var _local_2:int;
            while (_local_2 < this._achievements.length) {
                _local_3 = this._achievements[_local_2];
                if (_local_3.type == _arg_1.type){
                    this._achievements[_local_2] = _arg_1;
                };
                _local_2++;
            };
        }
        public function getProgress():int
        {
            var _local_2:AchievementData;
            var _local_1:int;
            for each (_local_2 in this._achievements) {
                _local_1 = (_local_1 + ((_local_2.finalLevel) ? _local_2.level : (_local_2.level - 1)));
            };
            return (_local_1);
        }
        public function getMaxProgress():int
        {
            var _local_2:AchievementData;
            var _local_1:int;
            for each (_local_2 in this._achievements) {
                _local_1 = (_local_1 + _local_2.levelCount);
            };
            return (_local_1);
        }
        public function get code():String
        {
            return (this._code);
        }
        public function get achievements():Array
        {
            return (this._achievements);
        }

    }
}//package com.sulake.habbo.quest

// getProgress = "_-2qB" (String#21088, DoABC#2)
// getMaxProgress = "_-2fb" (String#20674, DoABC#2)
// _code = "_-2XK" (String#20335, DoABC#2)
// AchievementData = "_-39C" (String#7494, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// achievements = "_-2JC" (String#19776, DoABC#2)
// finalLevel = "_-0or" (String#16006, DoABC#2)
// levelCount = "_-22S" (String#19107, DoABC#2)


