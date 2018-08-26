
package com.sulake.habbo.localization
{
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.runtime.IUnknown;
    import flash.utils.Dictionary;

    public interface IHabboLocalizationManager extends ICoreLocalizationManager, IUnknown 
    {

        function getKeyWithParams(_arg_1:String, _arg_2:Dictionary=null, _arg_3:String=""):String;
        function getAchievementName(_arg_1:String):String;
        function getAchievementDesc(_arg_1:String, _arg_2:int):String;
        function getBadgeBaseName(_arg_1:String):String;
        function getBadgeName(_arg_1:String):String;
        function getBadgeDesc(_arg_1:String):String;
        function getAchievementDescForFacebook(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:int):String;
        function getAchievementNameForFacebook(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:int):String;
        function setBadgePointLimit(_arg_1:String, _arg_2:int):void;
        function getPreviousLevelBadgeId(_arg_1:String):String;

    }
}//package com.sulake.habbo.localization

// setBadgePointLimit = "_-0HA" (String#3898, DoABC#2)
// getKeyWithParams = "_-2gI" (String#6875, DoABC#2)
// getAchievementDescForFacebook = "_-37y" (String#7469, DoABC#2)
// getAchievementNameForFacebook = "_-1o6" (String#5818, DoABC#2)
// getAchievementDesc = "_-2qD" (String#7083, DoABC#2)
// getBadgeBaseName = "_-25N" (String#6149, DoABC#2)
// getPreviousLevelBadgeId = "_-2Kq" (String#6459, DoABC#2)


