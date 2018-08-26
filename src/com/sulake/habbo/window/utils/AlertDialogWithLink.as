
package com.sulake.habbo.window.utils
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IButtonWindow;

    public class AlertDialogWithLink extends AlertDialog implements IAlertDialogWithLink 
    {

        protected var _linkTitle:String = "";
        protected var _linkUrl:String = "";

        public function AlertDialogWithLink(_arg_1:IHabboWindowManager, _arg_2:XML, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String, _arg_7:uint, _arg_8:Function)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_7, _arg_8);
            this.linkTitle = _arg_5;
            this.linkUrl = _arg_6;
        }
        override protected function dialogEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case "_alert_button_link":
                        HabboWebTools.navigateToURL(this._linkUrl, "_empty");
                        return;
                };
            };
            super.dialogEventProc(_arg_1, _arg_2);
        }
        public function set linkTitle(_arg_1:String):void
        {
            this._linkTitle = _arg_1;
            if (_window){
                IButtonWindow(_window.findChildByTag("LINK")).caption = this._linkTitle;
            };
        }
        public function get linkTitle():String
        {
            return (this._linkTitle);
        }
        public function set linkUrl(_arg_1:String):void
        {
            this._linkUrl = _arg_1;
        }
        public function get linkUrl():String
        {
            return (this._linkUrl);
        }

    }
}//package com.sulake.habbo.window.utils

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// linkTitle = "_-0z2" (String#4825, DoABC#2)
// linkUrl = "_-0Wo" (String#4244, DoABC#2)
// dialogEventProc = "_-2eS" (String#1917, DoABC#2)
// _linkTitle = "_-JV" (String#22983, DoABC#2)
// _linkUrl = "_-2GQ" (String#19658, DoABC#2)
// IAlertDialogWithLink = "_-0zQ" (String#4836, DoABC#2)
// AlertDialog = "_-eF" (String#8488, DoABC#2)
// AlertDialogWithLink = "_-1oC" (String#5823, DoABC#2)


