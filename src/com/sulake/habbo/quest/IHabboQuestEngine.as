
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IUnknown;

    public interface IHabboQuestEngine extends IUnknown 
    {

        function isTrackerVisible():Boolean;
        function showAchievements():void;
        function showQuests():void;

    }
}//package com.sulake.habbo.quest

// showAchievements = "_-1xg" (String#5986, DoABC#2)
// isTrackerVisible = "_-0Mk" (String#4017, DoABC#2)
// showQuests = "_-2ba" (String#6784, DoABC#2)
// IHabboQuestEngine = "_-2tn" (String#7154, DoABC#2)


