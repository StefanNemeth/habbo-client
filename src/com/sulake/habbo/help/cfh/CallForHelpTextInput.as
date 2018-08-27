
package com.sulake.habbo.help.cfh
{
    import com.sulake.habbo.help.help.HelpViewController;
    import com.sulake.habbo.help.help.IHelpViewController;
    import com.sulake.habbo.help.help.HelpUI;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import default.CallForHelpMessageComposer;

    public class CallForHelpTextInput extends HelpViewController implements IHelpViewController 
    {

        private static const _SafeStr_11344:int = 30;
        private static const _SafeStr_5168:int = (0xFF - 2);//253
        private static const _SafeStr_5167:int = 10;

        public function CallForHelpTextInput(_arg_1:HelpUI, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function render():void
        {
            if (container != null){
                container.dispose();
            };
            if (main.component.callForHelpData.userSelected){
                container = (buildXmlWindow("report_user_send") as IWindowContainer);
            }
            else {
                container = (buildXmlWindow("help_cfh_send") as IWindowContainer);
            };
            if (container == null){
                return;
            };
            var _local_1:IWindow = container.findChildByName("send");
            if (_local_1 != null){
                _local_1.setParamFlag(WindowParam._SafeStr_7434);
                _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onSend);
            };
            var _local_2:IWindow = container.findChildByName("cancel");
            if (_local_2 != null){
                _local_2.setParamFlag(WindowParam._SafeStr_7434);
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancel);
            };
            super.render();
        }
        private function onSend(_arg_1:WindowMouseEvent):void
        {
            this.sendCallForHelp();
        }
        private function onCancel(_arg_1:WindowMouseEvent):void
        {
            main.showUI(HabboHelpViewEnum.HHVE_HELP_FRONTPAGE);
        }
        override public function update(_arg_1:*=null):void
        {
            super.update(_arg_1);
            if (container == null){
                return;
            };
            var _local_2:ITextFieldWindow = (container.findChildByName("input") as ITextFieldWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.addEventListener(WindowEvent.WE_CHANGE, this.onTextWindowEvent);
        }
        private function onTextWindowEvent(_arg_1:WindowEvent):void
        {
            var _local_2:ITextFieldWindow = (container.findChildByName("input") as ITextFieldWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.maxChars = _SafeStr_5168;
            if (_local_2.numLines < _SafeStr_5167){
                return;
            };
            _local_2.text = _local_2.text.slice(0, (_local_2.text.length - 1));
            _local_2.maxChars = _local_2.length;
        }
        private function sendCallForHelp():void
        {
            if (container == null){
                return;
            };
            var inputField:ITextFieldWindow = (container.findChildByName("input") as ITextFieldWindow);
            if (inputField == null){
                return;
            };
            if (inputField.text == ""){
                windowManager.alert("${generic.alert.title}", "${help.cfh.error.nomsg}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
                return;
            };
            if (inputField.text.length < _SafeStr_11344){
                windowManager.alert("${generic.alert.title}", "${help.cfh.error.msgtooshort}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
                return;
            };
            main.sendMessage(new CallForHelpMessageComposer(inputField.text, 1, main.component.callForHelpData.topicIndex, main.component.callForHelpData.reportedUserId));
            main.hideUI();
        }

    }
}//package com.sulake.habbo.help.cfh

// _SafeStr_11344 = "_-Ry" (String#23323, DoABC#2)
// sendCallForHelp = "_-3Ib" (String#22222, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// HabboHelpViewEnum = "_-1e7" (String#18062, DoABC#2)
// IHelpViewController = "_-0cs" (String#4364, DoABC#2)
// HelpViewController = "_-IY" (String#8052, DoABC#2)
// CallForHelpTextInput = "_-2VL" (String#6670, DoABC#2)
// CallForHelpMessageComposer = "_-tO" (String#24422, DoABC#2)
// _SafeStr_5167 = "_-ev" (String#8496, DoABC#2)
// _SafeStr_5168 = "_-2sM" (String#7127, DoABC#2)
// WE_CHANGE = "_-1sp" (String#18670, DoABC#2)
// onTextWindowEvent = "_-0hH" (String#820, DoABC#2)
// onSend = "_-0qb" (String#4653, DoABC#2)
// onCancel = "_-3JX" (String#633, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// HHVE_HELP_FRONTPAGE = "_-2WD" (String#20292, DoABC#2)


