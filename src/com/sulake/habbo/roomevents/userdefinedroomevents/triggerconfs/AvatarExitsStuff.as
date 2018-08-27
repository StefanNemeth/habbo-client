
package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class AvatarExitsStuff implements TriggerConf 
    {

        public function get code():int
        {
            return (TriggerConfCodes._SafeStr_7119);
        }
        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID_OR_BY_TYPE);
        }
        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }
        public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = new Array();
            return (new Array());
        }
        public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            return ("");
        }
        public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
        }
        public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
        }
        public function get hasSpecialInputs():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs

// Triggerable = "_-2oD" (String#7043, DoABC#2)
// TriggerConf = "_-0ol" (String#4609, DoABC#2)
// AvatarExitsStuff = "_-0Vf" (String#4220, DoABC#2)
// TriggerConfCodes = "_-2-z" (String#6047, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// onInit = "_-10U" (String#4881, DoABC#2)
// onEditStart = "_-2Cw" (String#6305, DoABC#2)
// readIntParamsFromForm = "_-0uD" (String#4727, DoABC#2)
// readStringParamFromForm = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)
// _SafeStr_7119 = "_-0m5" (String#15898, DoABC#2)


