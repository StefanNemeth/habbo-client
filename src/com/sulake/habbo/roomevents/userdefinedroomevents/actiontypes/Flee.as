
package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class Flee implements ActionType 
    {

        public function get code():int
        {
            return (ActionTypeCodes._SafeStr_5249);
        }
        public function get allowDelaying():Boolean
        {
            return (false);
        }
        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl._SafeStr_5209);
        }
        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }
        public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
        }
        public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
        }
        public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            return (new Array());
        }
        public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            return ("");
        }
        public function get hasSpecialInputs():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes

// Triggerable = "_-2oD" (String#7043, DoABC#2)
// ActionType = "_-0Jp" (String#813, DoABC#2)
// ActionTypeCodes = "_-0wu" (String#4789, DoABC#2)
// allowDelaying = "_-4e" (String#7759, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// _SafeStr_5209 = "_-1vi" (String#18785, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// onInit = "_-10U" (String#4881, DoABC#2)
// onEditStart = "_-2Cw" (String#6305, DoABC#2)
// readIntParamsFromForm = "_-0uD" (String#4727, DoABC#2)
// readStringParamFromForm = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)
// _SafeStr_5249 = "_-06U" (String#14305, DoABC#2)


