
package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;

    public class Chat implements ActionType 
    {

        public function get code():int
        {
            return (ActionTypeCodes._SafeStr_5236);
        }
        public function get allowDelaying():Boolean
        {
            return (false);
        }
        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_NONE);
        }
        public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            return (new Array());
        }
        public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            return (this.getInput(_arg_1).text);
        }
        public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
        }
        public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            this.getInput(_arg_1).text = _arg_2.stringParam;
        }
        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }
        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }
        private function getInput(_arg_1:IWindowContainer):ITextFieldWindow
        {
            return (ITextFieldWindow(_arg_1.findChildByName("chat_message")));
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes

// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// Triggerable = "_-2oD" (String#7043, DoABC#2)
// ActionType = "_-0Jp" (String#813, DoABC#2)
// Chat = "_-2hB" (String#6895, DoABC#2)
// ActionTypeCodes = "_-0wu" (String#4789, DoABC#2)
// allowDelaying = "_-4e" (String#7759, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// onInit = "_-10U" (String#4881, DoABC#2)
// onEditStart = "_-2Cw" (String#6305, DoABC#2)
// readIntParamsFromForm = "_-0uD" (String#4727, DoABC#2)
// readStringParamFromForm = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)
// _SafeStr_5236 = "_-2Cs" (String#19517, DoABC#2)
// stringParam = "_-WR" (String#23508, DoABC#2)


