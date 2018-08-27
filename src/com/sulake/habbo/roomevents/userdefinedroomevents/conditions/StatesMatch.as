
package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ICheckBoxWindow;

    public class StatesMatch implements ConditionType 
    {

        public function get code():int
        {
            return (ConditionCodes._SafeStr_7666);
        }
        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID);
        }
        public function get hasStateSnapshot():Boolean
        {
            return (true);
        }
        public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
        }
        public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            this.select(this.getStateInput(_arg_1), _arg_2.getBoolean(0));
            this.select(this.getRotationInput(_arg_1), _arg_2.getBoolean(1));
            this.select(this.getLocationInput(_arg_1), _arg_2.getBoolean(2));
        }
        private function select(_arg_1:ICheckBoxWindow, _arg_2:Boolean):void
        {
            if (_arg_2){
                _arg_1.select();
            }
            else {
                _arg_1.unselect();
            };
        }
        public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = new Array();
            _local_2.push(this.getIntState(this.getStateInput(_arg_1)));
            _local_2.push(this.getIntState(this.getRotationInput(_arg_1)));
            _local_2.push(this.getIntState(this.getLocationInput(_arg_1)));
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
        private function getStateInput(_arg_1:IWindowContainer):ICheckBoxWindow
        {
            return (ICheckBoxWindow(_arg_1.findChildByName("include_state_checkbox")));
        }
        private function getRotationInput(_arg_1:IWindowContainer):ICheckBoxWindow
        {
            return (ICheckBoxWindow(_arg_1.findChildByName("include_rotation_checkbox")));
        }
        private function getLocationInput(_arg_1:IWindowContainer):ICheckBoxWindow
        {
            return (ICheckBoxWindow(_arg_1.findChildByName("include_location_checkbox")));
        }
        private function getIntState(_arg_1:ICheckBoxWindow):int
        {
            return (((_arg_1.isSelected) ? 1 : 0));
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.conditions

// ICheckBoxWindow = "_-1zu" (String#1793, DoABC#2)
// Triggerable = "_-2oD" (String#7043, DoABC#2)
// ConditionType = "_-262" (String#6162, DoABC#2)
// StatesMatch = "_-1vt" (String#5956, DoABC#2)
// ConditionCodes = "_-3Jq" (String#7699, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// onInit = "_-10U" (String#4881, DoABC#2)
// onEditStart = "_-2Cw" (String#6305, DoABC#2)
// readIntParamsFromForm = "_-0uD" (String#4727, DoABC#2)
// readStringParamFromForm = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)
// getStateInput = "_-Uz" (String#8304, DoABC#2)
// getRotationInput = "_-2Sb" (String#6622, DoABC#2)
// getLocationInput = "_-3Kh" (String#7716, DoABC#2)
// unselect = "_-2aK" (String#6764, DoABC#2)
// getIntState = "_-092" (String#3739, DoABC#2)
// _SafeStr_7666 = "_-7e" (String#22529, DoABC#2)


