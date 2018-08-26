
package com.sulake.habbo.friendlist
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import com.sulake.core.window.components.IFrameWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class AlertView implements IDisposable 
    {

        private static var _SafeStr_11204:Dictionary = new Dictionary();

        private var _friendList:HabboFriendList;
        private var _alert:IFrameWindow;
        private var _SafeStr_11205:String;
        private var _title:String;
        private var _disposed:Boolean;

        public function AlertView(_arg_1:HabboFriendList, _arg_2:String, _arg_3:String=null)
        {
            this._friendList = _arg_1;
            this._SafeStr_11205 = _arg_2;
            this._title = _arg_3;
        }
        public function show():void
        {
            var _local_1:IFrameWindow = IFrameWindow(_SafeStr_11204[this._SafeStr_11205]);
            if (_local_1 != null){
                _local_1.dispose();
            };
            this._alert = this.getAlert();
            if (this._title != null){
                this._alert.caption = this._title;
            };
            this.setupContent(this._alert.content);
            var _local_2:Rectangle = Util.getLocationRelativeTo(this._friendList.view.mainWindow, this._alert.width, this._alert.height);
            this._alert.x = _local_2.x;
            this._alert.y = _local_2.y;
            _SafeStr_11204[this._SafeStr_11205] = this._alert;
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this._alert != null){
                this._alert.destroy();
                this._alert = null;
            };
            this._friendList = null;
        }
        function setupContent(_arg_1:IWindowContainer):void
        {
        }
        function PollOfferDialog(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.dispose();
        }
        private function getAlert():IFrameWindow
        {
            var _local_1:IFrameWindow = IFrameWindow(this._friendList.getXmlWindow(this._SafeStr_11205));
            var _local_2:IWindow = _local_1.findChildByTag("close");
            _local_2.procedure = this.PollOfferDialog;
            return (_local_1);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get friendList():HabboFriendList
        {
            return (this._friendList);
        }

    }
}//package com.sulake.habbo.friendlist

// _SafeStr_11204 = "_-05E" (String#3670, DoABC#2)
// _SafeStr_11205 = "_-2Cx" (String#881, DoABC#2)
// getAlert = "_-396" (String#21851, DoABC#2)
// setupContent = "_-SD" (String#23333, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// AlertView = "_-2G6" (String#883, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// getLocationRelativeTo = "_-2tz" (String#21236, DoABC#2)


