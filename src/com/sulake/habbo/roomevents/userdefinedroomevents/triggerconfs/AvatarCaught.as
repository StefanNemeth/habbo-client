
package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class AvatarCaught implements TriggerConf 
    {

        public function get code():int
        {
            return (TriggerConfCodes._SafeStr_7114);
        }
        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_NONE);
        }
        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }
        public function Element(_arg_1:IWindowContainer):Array
        {
            return (new Array());
        }
        public function Element(_arg_1:IWindowContainer):String
        {
            return ("");
        }
        public function Element(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
        }
        public function Element(_arg_1:IWindowContainer, _arg_2:Triggerable):void
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
// AvatarCaught = "_-1N4" (String#5293, DoABC#2)
// TriggerConfCodes = "_-2-z" (String#6047, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// Element = "_-10U" (String#4881, DoABC#2)
// Element = "_-2Cw" (String#6305, DoABC#2)
// Element = "_-0uD" (String#4727, DoABC#2)
// Element = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)
// _SafeStr_7114 = "_-1CK" (String#16957, DoABC#2)


