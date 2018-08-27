
package com.sulake.habbo.navigator
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IFrameWindow;

    public class SimpleAlertView extends AlertView 
    {

        private var _text:String;

        public function SimpleAlertView(_arg_1:HabboNavigator, _arg_2:String, _arg_3:String)
        {
            super(_arg_1, "nav_simple_alert", _arg_2);
            this._text = _arg_3;
        }
        override function setupAlertWindow(_arg_1:IFrameWindow):void
        {
            var _local_2:IWindowContainer = _arg_1.content;
            ITextWindow(_local_2.findChildByName("body_text")).text = this._text;
            var _local_3:IWindow = _local_2.findChildByName("ok");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onOk);
            };
            _arg_1.tags.push("SimpleAlertView");
        }
        private function onOk(_arg_1:WindowMouseEvent):void
        {
            dispose();
        }

    }
}//package com.sulake.habbo.navigator

// setupAlertWindow = "_-2MF" (String#19894, DoABC#2)
// AlertView = "_-2G6" (String#883, DoABC#2)
// onOk = "_-39j" (String#457, DoABC#2)


