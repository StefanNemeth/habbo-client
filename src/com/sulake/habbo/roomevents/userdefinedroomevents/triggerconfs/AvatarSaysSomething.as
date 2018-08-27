
package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class AvatarSaysSomething implements TriggerConf 
    {

        public function get code():int
        {
            return (TriggerConfCodes._SafeStr_7115);
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
            var _local_2:Array = new Array();
            _local_2.push(((this.getMeRadio(_arg_1).isSelected) ? 1 : 0));
            return (_local_2);
        }
        public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            return (this.getInput(_arg_1).text);
        }
        public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
            _arg_1.findChildByName("me_txt").caption = _arg_2.userName;
        }
        public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            this.getInput(_arg_1).text = _arg_2.stringParam;
            if ((((_arg_2.intParams.length > 0)) && ((_arg_2.intParams[0] == 1)))){
                this.getSelector(_arg_1).setSelected(this.getMeRadio(_arg_1));
            }
            else {
                this.getSelector(_arg_1).setSelected(this.getAnyAvatarRadio(_arg_1));
            };
        }
        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }
        private function getInput(_arg_1:IWindowContainer):ITextFieldWindow
        {
            return (ITextFieldWindow(_arg_1.findChildByName("chat_txt")));
        }
        private function getAnyAvatarRadio(_arg_1:IWindowContainer):IRadioButtonWindow
        {
            return (IRadioButtonWindow(_arg_1.findChildByName("any_avatar_radio")));
        }
        private function getMeRadio(_arg_1:IWindowContainer):IRadioButtonWindow
        {
            return (IRadioButtonWindow(_arg_1.findChildByName("me_radio")));
        }
        private function getSelector(_arg_1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(_arg_1.findChildByName("avatar_radio")));
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs

// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// IRadioButtonWindow = "_-234" (String#1804, DoABC#2)
// Triggerable = "_-2oD" (String#7043, DoABC#2)
// TriggerConf = "_-0ol" (String#4609, DoABC#2)
// AvatarSaysSomething = "_-295" (String#19370, DoABC#2)
// TriggerConfCodes = "_-2-z" (String#6047, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// onInit = "_-10U" (String#4881, DoABC#2)
// onEditStart = "_-2Cw" (String#6305, DoABC#2)
// intParams = "_-kt" (String#24066, DoABC#2)
// readIntParamsFromForm = "_-0uD" (String#4727, DoABC#2)
// readStringParamFromForm = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)
// stringParam = "_-WR" (String#23508, DoABC#2)
// _SafeStr_7115 = "_-2Sg" (String#20144, DoABC#2)
// getSelector = "_-2AX" (String#6256, DoABC#2)
// getAnyAvatarRadio = "_-0Id" (String#3926, DoABC#2)


