
package com.sulake.habbo.ui.widget.furniture.placeholder
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetShowPlaceholderEvent;
    import flash.events.IEventDispatcher;

    public class PlaceholderWidget extends RoomWidgetBase 
    {

        private var _view:PlaceholderView;

        public function PlaceholderWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
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
            _arg_1.addEventListener(RoomWidgetShowPlaceholderEvent.RWSPE_SHOW_PLACEHOLDER, this.onShowEvent);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetShowPlaceholderEvent.RWSPE_SHOW_PLACEHOLDER, this.onShowEvent);
        }
        private function onShowEvent(_arg_1:RoomWidgetShowPlaceholderEvent):void
        {
            this.showInterface();
        }
        private function showInterface():void
        {
            if (this._view == null){
                this._view = new PlaceholderView(assets, windowManager);
            };
            this._view.showWindow();
        }
        private function hideInterface():void
        {
            if (this._view != null){
                this._view.dispose();
                this._view = null;
            };
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.placeholder

// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// PlaceholderWidget = "_-0Ea" (String#3840, DoABC#2)
// PlaceholderView = "_-0wE" (String#828, DoABC#2)
// RoomWidgetShowPlaceholderEvent = "_-3-p" (String#7300, DoABC#2)
// hideInterface = "_-29" (String#304, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// showInterface = "_-121" (String#162, DoABC#2)
// RWSPE_SHOW_PLACEHOLDER = "_-1-S" (String#16446, DoABC#2)
// onShowEvent = "_-1xi" (String#18876, DoABC#2)
// showWindow = "_-2ve" (String#21300, DoABC#2)


