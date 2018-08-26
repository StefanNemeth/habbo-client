
package com.sulake.habbo.quest
{
    import com.sulake.habbo.localization.IHabboLocalizationManager;

    public class FriendlyTime 
    {

        private static const _SafeStr_12289:int = 60;
        private static const _SafeStr_12290:int = (60 * 60);//3600
        private static const _SafeStr_12291:int = (3 * _SafeStr_12289);//180
        private static const _SafeStr_12292:int = (3 * _SafeStr_12290);//10800

        public static function getFriendlyTime(_arg_1:IHabboLocalizationManager, _arg_2:int):String
        {
            if (_arg_2 > _SafeStr_12292){
                return (getLocalization(_arg_1, "friendlytime.hours", Math.round((_arg_2 / _SafeStr_12290))));
            };
            if (_arg_2 > _SafeStr_12291){
                return (getLocalization(_arg_1, "friendlytime.minutes", Math.round((_arg_2 / _SafeStr_12289))));
            };
            return (getLocalization(_arg_1, "friendlytime.seconds", Math.round(_arg_2)));
        }
        public static function getLocalization(_arg_1:IHabboLocalizationManager, _arg_2:String, _arg_3:int):String
        {
            _arg_1.registerParameter(_arg_2, "amount", ("" + _arg_3));
            return (_arg_1.getKey(_arg_2, _arg_2));
        }

    }
}//package com.sulake.habbo.quest

// getFriendlyTime = "_-1ci" (String#17999, DoABC#2)
// _SafeStr_12289 = "_-1Vr" (String#17736, DoABC#2)
// _SafeStr_12290 = "_-3Ka" (String#22307, DoABC#2)
// _SafeStr_12291 = "_-2Dl" (String#19557, DoABC#2)
// _SafeStr_12292 = "_-3E4" (String#22037, DoABC#2)
// FriendlyTime = "_-1rL" (String#5880, DoABC#2)


