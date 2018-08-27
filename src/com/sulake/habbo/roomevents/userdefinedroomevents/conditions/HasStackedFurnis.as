
package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class HasStackedFurnis implements ConditionType 
    {

        public function get code():int
        {
            return (ConditionCodes._SafeStr_7663);
        }
        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID);
        }
        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }
        public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = new Array();
            _local_2.push(this.getEvalSelector(_arg_1).getSelected().id);
            return (_local_2);
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
            var _local_3:int = _arg_2.intParams[0];
            this.getEvalSelector(_arg_1).setSelected(this.getEvalRadio(_arg_1, _local_3));
        }
        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }
        private function getEvalRadio(_arg_1:IWindowContainer, _arg_2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(_arg_1.findChildByName((("eval_" + _arg_2) + "_radio"))));
        }
        private function getEvalSelector(_arg_1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(_arg_1.findChildByName("eval_selector")));
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.conditions

// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// IRadioButtonWindow = "_-234" (String#1804, DoABC#2)
// Triggerable = "_-2oD" (String#7043, DoABC#2)
// ConditionType = "_-262" (String#6162, DoABC#2)
// HasStackedFurnis = "_-zW" (String#8868, DoABC#2)
// ConditionCodes = "_-3Jq" (String#7699, DoABC#2)
// getSelected = "_-88" (String#7825, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// onInit = "_-10U" (String#4881, DoABC#2)
// onEditStart = "_-2Cw" (String#6305, DoABC#2)
// intParams = "_-kt" (String#24066, DoABC#2)
// readIntParamsFromForm = "_-0uD" (String#4727, DoABC#2)
// readStringParamFromForm = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)
// _SafeStr_7663 = "_-358" (String#21700, DoABC#2)
// getEvalSelector = "_-QT" (String#23267, DoABC#2)
// getEvalRadio = "_-20Q" (String#19028, DoABC#2)


