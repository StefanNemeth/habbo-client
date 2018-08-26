
package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;

    public class ToggleToRandomState extends DefaultActionType 
    {

        override public function get code():int
        {
            return (ActionTypeCodes._SafeStr_5238);
        }
        override public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl._SafeStr_5209);
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes

// DefaultActionType = "_-165" (String#4996, DoABC#2)
// ToggleToRandomState = "_-0X" (String#4249, DoABC#2)
// ActionTypeCodes = "_-0wu" (String#4789, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// _SafeStr_5209 = "_-1vi" (String#18785, DoABC#2)
// _SafeStr_5238 = "_-1p5" (String#18504, DoABC#2)


