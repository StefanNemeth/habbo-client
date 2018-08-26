
package com.sulake.habbo.quest
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;

    public class AchievementCategories 
    {

        private var _SafeStr_11350:Dictionary;
        private var _categoryList:Array;

        public function AchievementCategories(_arg_1:Array)
        {
            var _local_2:AchievementData;
            var _local_3:AchievementCategory;
            this._SafeStr_11350 = new Dictionary();
            this._categoryList = new Array();
            super();
            for each (_local_2 in _arg_1) {
                _local_3 = this._SafeStr_11350[_local_2.category];
                if (_local_3 == null){
                    _local_3 = new AchievementCategory(_local_2.category);
                    this._SafeStr_11350[_local_2.category] = _local_3;
                    this._categoryList.push(_local_3);
                };
                _local_3.add(_local_2);
            };
        }
        public function update(_arg_1:AchievementData):void
        {
            var _local_2:AchievementCategory = this._SafeStr_11350[_arg_1.category];
            _local_2.update(_arg_1);
        }
        public function get categoryList():Array
        {
            return (this._categoryList);
        }
        public function getMaxProgress():int
        {
            var _local_2:AchievementCategory;
            var _local_1:int;
            for each (_local_2 in this._categoryList) {
                _local_1 = (_local_1 + _local_2.getMaxProgress());
            };
            return (_local_1);
        }
        public function getProgress():int
        {
            var _local_2:AchievementCategory;
            var _local_1:int;
            for each (_local_2 in this._categoryList) {
                _local_1 = (_local_1 + _local_2.getProgress());
            };
            return (_local_1);
        }
        public function getCategoryByCode(_arg_1:String):AchievementCategory
        {
            var _local_2:AchievementCategory;
            for each (_local_2 in this._categoryList) {
                if (_local_2.code == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }

    }
}//package com.sulake.habbo.quest

// _SafeStr_11350 = "_-2dK" (String#6818, DoABC#2)
// getCategoryByCode = "_-0JX" (String#14823, DoABC#2)
// categoryList = "_-32E" (String#21590, DoABC#2)
// getProgress = "_-2qB" (String#21088, DoABC#2)
// getMaxProgress = "_-2fb" (String#20674, DoABC#2)
// _categoryList = "_-3CH" (String#21971, DoABC#2)
// AchievementData = "_-39C" (String#7494, DoABC#2)
// AchievementCategories = "_-Do" (String#7948, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)


