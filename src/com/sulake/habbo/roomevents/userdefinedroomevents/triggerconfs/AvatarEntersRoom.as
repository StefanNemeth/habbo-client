
package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class AvatarEntersRoom implements TriggerConf 
    {

        private var _cont:IWindowContainer;

        public function get code():int
        {
            return (TriggerConfCodes._SafeStr_7124);
        }
        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_NONE);
        }
        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }
        public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            return (new Array());
        }
        public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            var _local_2:String = this.getInput().text;
            return (((this.getCertainAvatarRadio().isSelected) ? _local_2 : ""));
        }
        public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
            this._cont = _arg_1;
            this.getCertainAvatarRadio().addEventListener(WindowEvent.WE_SELECT, this.onCertainAvatarSelect);
            this.getCertainAvatarRadio().addEventListener(WindowEvent.WE_UNSELECT, this.onCertainAvatarUnselect);
        }
        public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            if (_arg_2.stringParam != ""){
                this.getSelector().setSelected(this.getCertainAvatarRadio());
                this.getInput().text = _arg_2.stringParam;
                this.getInput().visible = true;
            }
            else {
                this.getSelector().setSelected(this.getAnyAvatarRadio());
                this.getInput().text = "";
                this.getInput().visible = false;
            };
        }
        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }
        private function getInput():ITextFieldWindow
        {
            return (ITextFieldWindow(this._cont.findChildByName("avatar_name_txt")));
        }
        private function getCertainAvatarRadio():IRadioButtonWindow
        {
            return (IRadioButtonWindow(this._cont.findChildByName("certain_avatar_radio")));
        }
        private function getAnyAvatarRadio():IRadioButtonWindow
        {
            return (IRadioButtonWindow(this._cont.findChildByName("any_avatar_radio")));
        }
        private function getSelector():ISelectorWindow
        {
            return (ISelectorWindow(this._cont.findChildByName("avatar_radio")));
        }
        private function onCertainAvatarSelect(_arg_1:WindowEvent):void
        {
            this.getInput().visible = true;
        }
        private function onCertainAvatarUnselect(_arg_1:WindowEvent):void
        {
            this.getInput().text = "";
            this.getInput().visible = false;
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// IRadioButtonWindow = "_-234" (String#1804, DoABC#2)
// Triggerable = "_-2oD" (String#7043, DoABC#2)
// TriggerConf = "_-0ol" (String#4609, DoABC#2)
// AvatarEntersRoom = "_-32a" (String#21599, DoABC#2)
// TriggerConfCodes = "_-2-z" (String#6047, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// onInit = "_-10U" (String#4881, DoABC#2)
// onEditStart = "_-2Cw" (String#6305, DoABC#2)
// readIntParamsFromForm = "_-0uD" (String#4727, DoABC#2)
// readStringParamFromForm = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)
// stringParam = "_-WR" (String#23508, DoABC#2)
// WE_SELECT = "_-335" (String#21624, DoABC#2)
// WE_UNSELECT = "_-sx" (String#24402, DoABC#2)
// getSelector = "_-2AX" (String#6256, DoABC#2)
// getAnyAvatarRadio = "_-0Id" (String#3926, DoABC#2)
// _SafeStr_7124 = "_-1mT" (String#18399, DoABC#2)
// getCertainAvatarRadio = "_-1Mb" (String#17383, DoABC#2)
// onCertainAvatarSelect = "_-1VI" (String#17713, DoABC#2)
// onCertainAvatarUnselect = "_-dX" (String#23782, DoABC#2)


