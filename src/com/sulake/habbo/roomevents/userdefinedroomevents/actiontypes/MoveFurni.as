
package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class MoveFurni implements ActionType 
    {

        public function get code():int
        {
            return (ActionTypeCodes._SafeStr_5207);
        }
        public function get allowDelaying():Boolean
        {
            return (true);
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
            _arg_2.refreshButton(_arg_1, "move_0", true, null, 0);
            _arg_2.refreshButton(_arg_1, "move_2", true, null, 0);
            _arg_2.refreshButton(_arg_1, "move_4", true, null, 0);
            _arg_2.refreshButton(_arg_1, "move_6", true, null, 0);
            _arg_2.refreshButton(_arg_1, "move_diag", true, null, 0);
            _arg_2.refreshButton(_arg_1, "move_rnd", true, null, 0);
            _arg_2.refreshButton(_arg_1, "move_vrt", true, null, 0);
            _arg_2.refreshButton(_arg_1, "rotate_ccw", true, null, 0);
            _arg_2.refreshButton(_arg_1, "rotate_cw", true, null, 0);
        }
        public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            var _local_3:int = _arg_2.intParams[0];
            var _local_4:int = _arg_2.intParams[1];
            this.getMoveSelector(_arg_1).setSelected(this.getMoveRadio(_arg_1, _local_3));
            this.getRotateSelector(_arg_1).setSelected(this.getRotateRadio(_arg_1, _local_4));
        }
        public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = new Array();
            var _local_3:int = this.getMoveSelector(_arg_1).getSelected().id;
            var _local_4:int = this.getRotateSelector(_arg_1).getSelected().id;
            _local_2.push(_local_3);
            _local_2.push(_local_4);
            return (_local_2);
        }
        public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            return ("");
        }
        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }
        private function getMoveRadio(_arg_1:IWindowContainer, _arg_2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(_arg_1.findChildByName((("move_" + _arg_2) + "_radio"))));
        }
        private function getRotateRadio(_arg_1:IWindowContainer, _arg_2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(_arg_1.findChildByName((("rotate_" + _arg_2) + "_radio"))));
        }
        private function getMoveSelector(_arg_1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(_arg_1.findChildByName("move_selector")));
        }
        private function getRotateSelector(_arg_1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(_arg_1.findChildByName("rotate_selector")));
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes

// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// IRadioButtonWindow = "_-234" (String#1804, DoABC#2)
// Triggerable = "_-2oD" (String#7043, DoABC#2)
// ActionType = "_-0Jp" (String#813, DoABC#2)
// MoveFurni = "_-9H" (String#7850, DoABC#2)
// ActionTypeCodes = "_-0wu" (String#4789, DoABC#2)
// getSelected = "_-88" (String#7825, DoABC#2)
// allowDelaying = "_-4e" (String#7759, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// _SafeStr_5207 = "_-09F" (String#14417, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// _SafeStr_5209 = "_-1vi" (String#18785, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// onInit = "_-10U" (String#4881, DoABC#2)
// onEditStart = "_-2Cw" (String#6305, DoABC#2)
// intParams = "_-kt" (String#24066, DoABC#2)
// getMoveSelector = "_-0rB" (String#16094, DoABC#2)
// getMoveRadio = "_-1qS" (String#18562, DoABC#2)
// getRotateSelector = "_-0Lh" (String#14900, DoABC#2)
// getRotateRadio = "_-2wY" (String#21329, DoABC#2)
// readIntParamsFromForm = "_-0uD" (String#4727, DoABC#2)
// readStringParamFromForm = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)


