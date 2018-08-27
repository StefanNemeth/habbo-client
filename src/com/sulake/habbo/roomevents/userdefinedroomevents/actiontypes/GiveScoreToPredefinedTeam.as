
package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class GiveScoreToPredefinedTeam extends GiveScore 
    {

        override public function get code():int
        {
            return (ActionTypeCodes._SafeStr_5245);
        }
        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            super.onEditStart(_arg_1, _arg_2);
            var _local_3:int = _arg_2.intParams[2];
            this.getTeamSelector(_arg_1).setSelected(this.getTeamRadio(_arg_1, _local_3));
        }
        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = super.readIntParamsFromForm(_arg_1);
            _local_2.push(this.getTeamSelector(_arg_1).getSelected().id);
            return (_local_2);
        }
        private function getTeamRadio(_arg_1:IWindowContainer, _arg_2:int):IRadioButtonWindow
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
// GiveScore = "_-3A7" (String#7514, DoABC#2)
// GiveScoreToPredefinedTeam = "_-25" (String#6139, DoABC#2)
// ActionTypeCodes = "_-0wu" (String#4789, DoABC#2)
// getSelected = "_-88" (String#7825, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// onEditStart = "_-2Cw" (String#6305, DoABC#2)
// intParams = "_-kt" (String#24066, DoABC#2)
// readIntParamsFromForm = "_-0uD" (String#4727, DoABC#2)
// _SafeStr_5245 = "_-0rp" (String#16114, DoABC#2)
// getTeamRadio = "_-01d" (String#1389, DoABC#2)


