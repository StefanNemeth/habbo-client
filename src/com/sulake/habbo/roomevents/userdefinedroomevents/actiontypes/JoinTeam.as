
package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class JoinTeam implements ActionType 
    {

        public function get code():int
        {
            return (ActionTypeCodes._SafeStr_5248);
        }
        public function get allowDelaying():Boolean
        {
            return (false);
        }
        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_NONE);
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
            var _local_3:int = _arg_2.intParams[0];
            this.getTeamSelector(_arg_1).setSelected(this.ActorIsInTeam(_arg_1, _local_3));
        }
        public function Element(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = new Array();
            _local_2.push(this.getTeamSelector(_arg_1).ISelectorWindow().id);
            return (_local_2);
        }
        public function Element(_arg_1:IWindowContainer):String
        {
            return ("");
        }
        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }
        private function ActorIsInTeam(_arg_1:IWindowContainer, _arg_2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(_arg_1.findChildByName((("team_" + _arg_2) + "_radio"))));
        }
        private function getTeamSelector(_arg_1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(_arg_1.findChildByName("team_selector")));
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes

// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// IRadioButtonWindow = "_-234" (String#1804, DoABC#2)
// Triggerable = "_-2oD" (String#7043, DoABC#2)
// ActionType = "_-0Jp" (String#813, DoABC#2)
// JoinTeam = "_-0Rr" (String#4133, DoABC#2)
// ActionTypeCodes = "_-0wu" (String#4789, DoABC#2)
// ISelectorWindow = "_-88" (String#7825, DoABC#2)
// allowDelaying = "_-4e" (String#7759, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// Element = "_-10U" (String#4881, DoABC#2)
// Element = "_-2Cw" (String#6305, DoABC#2)
// intParams = "_-kt" (String#24066, DoABC#2)
// Element = "_-0uD" (String#4727, DoABC#2)
// Element = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)
// ActorIsInTeam = "_-01d" (String#1389, DoABC#2)
// _SafeStr_5248 = "_-06B" (String#14291, DoABC#2)


