
package com.sulake.habbo.ui.widget
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.IWindow;

    public class RoomWidgetBase implements IRoomWidget 
    {

        private var _disposed:Boolean = false;
        private var _events:EventDispatcher;
        private var _messageListener:IRoomWidgetMessageListener;
        private var _windowManager:IHabboWindowManager;
        protected var _assets:IAssetLibrary;
        protected var _localizations:IHabboLocalizationManager;
        protected var _handler:IRoomWidgetHandler;

        public function RoomWidgetBase(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            this._handler = _arg_1;
            this._windowManager = _arg_2;
            this._assets = _arg_3;
            this._localizations = _arg_4;
        }
        public function get state():int
        {
            return (0);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function initialize(_arg_1:int=0):void
        {
        }
        public function dispose():void
        {
            if (this.disposed){
                return;
            };
            this._messageListener = null;
            this._windowManager = null;
            if (((!((this._events == null))) && (!(this._events.disposed)))){
                this.RoomChatWidget(this._events);
            };
            if (this._handler){
                this._handler.dispose();
                this._handler = null;
            };
            this._events = null;
            this._assets = null;
            this._localizations = null;
            this._disposed = true;
        }
        public function set messageListener(_arg_1:IRoomWidgetMessageListener):void
        {
            this._messageListener = _arg_1;
        }
        public function get messageListener():IRoomWidgetMessageListener
        {
            return (this._messageListener);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get assets():IAssetLibrary
        {
            return (this._assets);
        }
        public function get localizations():IHabboLocalizationManager
        {
            return (this._localizations);
        }
        public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if ((_arg_1 is EventDispatcher)){
                this._events = (_arg_1 as EventDispatcher);
            };
        }
        public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
        }
        public function get mainWindow():IWindow
        {
            return (null);
        }

    }
}//package com.sulake.habbo.ui.widget

// IRoomWidgetMessageListener = "_-2FI" (String#6349, DoABC#2)
// IRoomWidget = "_-1r4" (String#5876, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// RoomChatWidget = "_-0-c" (String#3556, DoABC#2)
// _handler = "_-1Eb" (String#5153, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// _localizations = "_-0il" (String#358, DoABC#2)
// _messageListener = "_-16t" (String#833, DoABC#2)


