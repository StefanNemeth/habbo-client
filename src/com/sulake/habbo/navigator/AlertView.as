
package com.sulake.habbo.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class AlertView implements IDisposable 
    {

        private static var _SafeStr_11204:Dictionary = new Dictionary();

        private var _navigator:HabboNavigator;
        protected var _SafeStr_12012:IFrameWindow;
        protected var _SafeStr_11205:String;
        protected var _title:String;
        protected var _disposed:Boolean;

        public function AlertView(_arg_1:HabboNavigator, _arg_2:String, _arg_3:String=null)
        {
            this._navigator = _arg_1;
            this._SafeStr_11205 = _arg_2;
            this._title = _arg_3;
        }
        public static function AlertView(_arg_1:IWindow):AlertView
        {
            var _local_2:AlertView;
            if (_SafeStr_11204 != null){
                for each (_local_2 in _SafeStr_11204) {
                    if (_local_2._SafeStr_12012 == _arg_1){
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        public function show():void
        {
            var _local_1:AlertView = (_SafeStr_11204[this._SafeStr_11205] as AlertView);
            if (_local_1 != null){
                _local_1.dispose();
            };
            this._SafeStr_12012 = this.getAlertWindow();
            if (this._title != null){
                this._SafeStr_12012.caption = this._title;
            };
            this.setupAlertWindow(this._SafeStr_12012);
            var _local_2:Rectangle = Util.getLocationRelativeTo(this._SafeStr_12012.desktop, this._SafeStr_12012.width, this._SafeStr_12012.height);
            this._SafeStr_12012.x = _local_2.x;
            this._SafeStr_12012.y = _local_2.y;
            _SafeStr_11204[this._SafeStr_11205] = this;
            this._SafeStr_12012.activate();
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            if (_SafeStr_11204[this._SafeStr_11205] == this){
                _SafeStr_11204[this._SafeStr_11205] = null;
            };
            this._disposed = true;
            if (this._SafeStr_12012 != null){
                this._SafeStr_12012.destroy();
                this._SafeStr_12012 = null;
            };
            this._navigator = null;
        }
        function setupAlertWindow(_arg_1:IFrameWindow):void
        {
        }
        function PollOfferDialog(_arg_1:WindowMouseEvent):void
        {
            this.dispose();
        }
        private function getAlertWindow():IFrameWindow
        {
            var _local_1:IFrameWindow = (this._navigator.getXmlWindow(this._SafeStr_11205, 2) as IFrameWindow);
            var _local_2:IWindow = _local_1.findChildByTag("close");
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollOfferDialog);
            };
            return (_local_1);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get navigator():HabboNavigator
        {
            return (this._navigator);
        }

    }
}//package com.sulake.habbo.navigator

// _SafeStr_11204 = "_-05E" (String#3670, DoABC#2)
// _SafeStr_11205 = "_-2Cx" (String#881, DoABC#2)
// AlertView = "_-3F7" (String#22083, DoABC#2)
// _SafeStr_12012 = "_-2ko" (String#20877, DoABC#2)
// getAlertWindow = "_-3FQ" (String#22095, DoABC#2)
// setupAlertWindow = "_-2MF" (String#19894, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// AlertView = "_-2G6" (String#883, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// getLocationRelativeTo = "_-2tz" (String#21236, DoABC#2)


