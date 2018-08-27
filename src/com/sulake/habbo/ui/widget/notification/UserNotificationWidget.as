
package com.sulake.habbo.ui.widget.notification
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserNotificationEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.core.localization.ILocalization;

    public class UserNotificationWidget extends RoomWidgetBase 
    {

        private var _view:UserNotificationView;

        public function UserNotificationWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        override public function dispose():void
        {
            if (this._view != null){
                this._view.dispose();
                this._view = null;
            };
            super.dispose();
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetUserNotificationEvent.RWUNE_NOTIFICATION, this.onDisplayNotification);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetUserNotificationEvent.RWUNE_NOTIFICATION, this.onDisplayNotification);
            super.unregisterUpdateEvents(_arg_1);
        }
        protected function onDisplayNotification(_arg_1:RoomWidgetUserNotificationEvent):void
        {
            var _local_2:ILocalization;
            Logger.log(((("Notification: " + _arg_1.title) + " ") + _arg_1.message));
            if (!this._view){
                this._view = new UserNotificationView(this);
            };
            _local_2 = _localizations.getLocalization(_arg_1.title);
            var _local_3:String = ((_local_2) ? _local_2.raw : _arg_1.title);
            _local_2 = _localizations.getLocalization(_arg_1.message);
            var _local_4:String = ((_local_2) ? _local_2.raw : _arg_1.message);
            var _local_5:Array = _arg_1.parameters;
            var _local_6:int;
            while (_local_6 < _local_5.length) {
                _local_4 = _local_4.replace(_local_5[_local_6], _local_5[(_local_6 + 1)]);
                _local_6 = (_local_6 + 2);
            };
            this._view.showNotification(_local_3, _local_4);
        }

    }
}//package com.sulake.habbo.ui.widget.notification

// ILocalization = "_-2EY" (String#1839, DoABC#2)
// onDisplayNotification = "_-0w" (String#16273, DoABC#2)
// showNotification = "_-1jh" (String#18271, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// UserNotificationWidget = "_-25q" (String#6157, DoABC#2)
// UserNotificationView = "_-0CT" (String#3799, DoABC#2)
// RoomWidgetUserNotificationEvent = "_-0ns" (String#4588, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// _localizations = "_-0il" (String#358, DoABC#2)
// RWUNE_NOTIFICATION = "_-0Vj" (String#4221, DoABC#2)
// raw = "_-Xc" (String#8361, DoABC#2)


