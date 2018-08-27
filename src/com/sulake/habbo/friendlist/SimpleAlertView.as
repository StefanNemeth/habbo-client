
package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class SimpleAlertView extends AlertView 
    {

        private var _text:String;

        public function SimpleAlertView(_arg_1:HabboFriendList, _arg_2:String, _arg_3:String)
        {
            super(_arg_1, "simple_alert", _arg_2);
            this._text = _arg_3;
        }
        override function setupContent(_arg_1:IWindowContainer):void
        {
            ITextWindow(_arg_1.findChildByName("body_text")).text = this._text;
            _arg_1.findChildByName("ok").procedure = this.onOk;
        }
        private function onOk(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            dispose();
        }

    }
}//package com.sulake.habbo.friendlist

// setupContent = "_-SD" (String#23333, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// AlertView = "_-2G6" (String#883, DoABC#2)
// onOk = "_-39j" (String#457, DoABC#2)


