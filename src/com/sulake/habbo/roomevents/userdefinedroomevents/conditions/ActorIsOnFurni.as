
package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class ActorIsOnFurni implements ConditionType 
    {

        public function get code():int
        {
            return (ConditionCodes._SafeStr_7660);
        }
        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID);
        }
        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }
        public function Element(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
        }
        public function Element(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
        }
        public function Element(_arg_1:IWindowContainer):Array
        {
            return (new Array());
        }
        public function Element(_arg_1:IWindowContainer):String
        {
            return ("");
        }
        public function get hasSpecialInputs():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.conditions

// Triggerable = "_-2oD" (String#7043, DoABC#2)
// ConditionType = "_-262" (String#6162, DoABC#2)
// ActorIsOnFurni = "_-WT" (String#8331, DoABC#2)
// ConditionCodes = "_-3Jq" (String#7699, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// Element = "_-10U" (String#4881, DoABC#2)
// Element = "_-2Cw" (String#6305, DoABC#2)
// Element = "_-0uD" (String#4727, DoABC#2)
// Element = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)
// _SafeStr_7660 = "_-EF" (String#22781, DoABC#2)


