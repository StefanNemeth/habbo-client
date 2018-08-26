
package com.sulake.habbo.ui.widget.notification
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class UserNotificationView implements IDisposable 
    {

        protected static const _SafeStr_14095:String = "button_ok";
        protected static const _SafeStr_14096:String = "text_title";
        protected static const DESCRIPTION_NAME:String = "text_description";
        protected static const _SafeStr_14097:String = "widget_notification_frame";

        private var _widget:UserNotificationWidget;
        private var _disposed:Boolean = false;
        private var _SafeStr_14098:Array;

        public function UserNotificationView(_arg_1:UserNotificationWidget)
        {
            this._widget = _arg_1;
            this._SafeStr_14098 = new Array();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (this._SafeStr_14098){
                    while (this._SafeStr_14098.length > 0) {
                        this._SafeStr_14098.pop().dispose();
                    };
                    this._SafeStr_14098 = null;
                };
                this._widget = null;
                this._disposed = true;
            };
        }
        public function UserNotificationView(title:String, description:String):Boolean
        {
            var asset:XmlAsset = (this._widget.assets.getAssetByName("notification") as XmlAsset);
            if (!asset){
                return (false);
            };
            var xml:XML = XML(asset.content);
            var dialog:IFrameWindow = IFrameWindow(this._widget.windowManager.buildFromXML(xml));
            if (!dialog){
                return (false);
            };
            dialog.caption = title;
            dialog.findChildByName(_SafeStr_14096).caption = title;
            dialog.findChildByName(DESCRIPTION_NAME).caption = description;
            dialog.center();
            dialog.findChildByName(_SafeStr_14095).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, function (_arg_1:WindowMouseEvent):void
            {
                hideNotification(IFrameWindow(_arg_1.window.host));
            });
            dialog.findChildByName("header_button_close").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, function (_arg_1:WindowMouseEvent):void
            {
                hideNotification(IFrameWindow(_arg_1.window.host));
            });
            this._SafeStr_14098.push(dialog);
            return (true);
        }
        public function hideNotification(_arg_1:IFrameWindow):void
        {
            var _local_2:int;
            if (_arg_1 != null){
                _local_2 = this._SafeStr_14098.indexOf(_arg_1);
                if (_local_2 > -1){
                    this._SafeStr_14098.splice(_local_2, 1);
                };
                _arg_1.dispose();
            };
        }

    }
}//package com.sulake.habbo.ui.widget.notification

// UserNotificationView = "_-1jh" (String#18271, DoABC#2)
// _SafeStr_14095 = "_-1m" (String#18376, DoABC#2)
// _SafeStr_14096 = "_-0hE" (String#15720, DoABC#2)
// _SafeStr_14097 = "_-1sJ" (String#18644, DoABC#2)
// _SafeStr_14098 = "_-0f7" (String#15633, DoABC#2)
// UserNotificationWidget = "_-25q" (String#6157, DoABC#2)
// UserNotificationView = "_-0CT" (String#3799, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)


